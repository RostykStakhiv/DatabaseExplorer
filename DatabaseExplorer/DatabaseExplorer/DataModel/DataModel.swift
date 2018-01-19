//
//  DataModel.swift
//  Mitwelt
//
//  Created by Rostyslav Stakhiv on 8/2/17.
//  Copyright © 2017 Rostyslav Stakhiv. All rights reserved.
//

import Foundation
import CoreData

class DataModel {
    private var objectUniqueIndex = 0
    
    static let shared = DataModel()
    
    private(set) var lastCreatedObjectID: Int64 = UserDefaults.standard.value(forKey: Constants.lastCreatedObjectIDKey) as? Int64 ?? 0
    
    private init() {
    }
    
    //MARK: Cache
    private lazy var rootObjectsCache: [Object] = {
        return self.getRootObjectsFromDatabase()
    }()
    
    private lazy var objectsCache: [Object: [Object]] = {
        var localObjects = [Object: [Object]]()
        setChildrenForObjects(self.getRootObjectsFromDatabase(), inDict: &localObjects)
        
        return localObjects
    }()
    
    // MARK: Core Data Stack setup
    private lazy var managedObjectContext: NSManagedObjectContext = {
        
        var managedObjectContext: NSManagedObjectContext?
        
        let coordinator = self.persistentStoreCoordinator
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext?.persistentStoreCoordinator = coordinator
        return managedObjectContext!
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "DatabaseExplorer", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("DatabaseExplorer.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            // Configure automatic migration.
            let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            do {
                try FileManager.default.removeItem(at: url)
                try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
            } catch {
                // Report any error we got.
                var dict = [String: AnyObject]()
                dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
                dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
                
                dict[NSUnderlyingErrorKey] = error as NSError
                let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
                // Replace this with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
                abort()
            }
        }
        
        return coordinator
    }()
    
    // MARK: private
    private lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    private func setChildrenForObjects(_ objects: [Object], inDict dict: inout [Object: [Object]]) {
        for object in objects {
            let children = fetchChildrenForObject(object)
            
            if children.count > 0 {
                setChildrenForObjects(children, inDict: &dict)
            }
            
            dict[object] = children
        }
    }
    
    // MARK: public
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                //TODO: Handle error
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: Context
    var context: NSManagedObjectContext {
        get {
            return self.managedObjectContext
        }
    }
    
    
    //MARK: Private Methods
    private func recycleUniqueEntity(entity: Object, id: Int64) -> Any? {
        guard let fetchedEntity = fetchUniqueEntity(request: entity.fetchRequest(id: id)) else {
            guard let entityName = entity.entity.name else {
                return nil
            }
            
            return emptyObject(name: entityName, context: managedObjectContext)
        }
        
        return fetchedEntity
    }
    
    private func fetchEntities(request: NSFetchRequest<NSFetchRequestResult>) -> [Any] {
        do {
            let fetchedObjects = try managedObjectContext.fetch(request)
            return fetchedObjects
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    private func fetchUniqueEntity(request: NSFetchRequest<NSFetchRequestResult>) -> Any? {
        let fetchedObjects = fetchEntities(request: request)
        assert(fetchedObjects.count <= 1, "only one object can exist with specified id")
        
        if fetchedObjects.count > 1 {
            // try to recover by deleting all objects with given id
            for fetchedObject in fetchedObjects {
                managedObjectContext.delete(fetchedObject as! NSManagedObject)
            }
            
            return nil
        } else if fetchedObjects.count == 1 {
            return fetchedObjects[0]
        }
        
        return nil
    }
    
    //MARK: Insertion
    func emptyObject(name: String, context: NSManagedObjectContext?) -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: name, in: managedObjectContext)!
        return NSManagedObject(entity:entity, insertInto: context)
    }
    
    func insertObject<T: Object>(withModel objectModel: T) -> Bool {
        guard let entityName = objectModel.entity.name, let insertedObject = self.emptyObject(name: entityName, context: managedObjectContext) as? T else {
            return false
        }
        
        guard insertedObject.parseWithModel(objectModel) else {
            managedObjectContext.delete(insertedObject)
            return false
        }
        
        insertedObject.uniqueID = self.lastCreatedObjectID
        lastCreatedObjectID = lastCreatedObjectID + 1
        insertedObject.createDate = Date() as NSDate
        
        return true
    }
    
    //MARK: Fetching
    func fetchRootObjects() -> [Object] {
        guard context.hasChanges == true else {
            return rootObjectsCache
        }
        
        let results = getRootObjectsFromDatabase()
        rootObjectsCache = results
        return results
    }
    
    func fetchChildrenForObject(_ object: Object) -> [Object] {
        let objectFetchRequest: NSFetchRequest<Object> = Object.fetchRequest()
        objectFetchRequest.predicate = NSPredicate(format: "majorID == '\(object.uniqueID)'")
        let results = self.fetchEntities(request: objectFetchRequest as! NSFetchRequest<NSFetchRequestResult>) as? [Object] ?? [Object]()
        return results
    }
    
    //MARK: Private Fetching
    private func getRootObjectsFromDatabase() -> [Object] {
        let rootObjectsFetchRequest: NSFetchRequest<Object> = Object.fetchRequest()
        rootObjectsFetchRequest.predicate = NSPredicate(format: "majorID == '\(0)'")
        let results = self.fetchEntities(request: rootObjectsFetchRequest as! NSFetchRequest<NSFetchRequestResult>) as? [Object] ?? [Object]()
        
        return results
    }
}
