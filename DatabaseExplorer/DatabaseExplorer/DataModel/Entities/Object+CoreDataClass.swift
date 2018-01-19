//
//  Object+CoreDataClass.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/15/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Object)
public class Object: NSManagedObject {
    
    class var humanReadableEntityName: String {
        get {
            return "Object"
        }
    }

    func fetchRequest(id: Int64) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Object.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uniqueID == '\(id)'")
        return fetchRequest
    }
    
    func parseWithModel(_ model: Object) -> Bool {
        self.createDate = model.createDate
        self.name = model.name
        self.majorID = model.majorID
        self.uniqueID = model.uniqueID
        
        return true
    }
}
