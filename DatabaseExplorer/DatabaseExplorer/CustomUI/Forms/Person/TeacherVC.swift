//
//  TeacherVC.swift
//  DatabaseExplorer
//
//  Created by admin on 1/31/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//

import Cocoa

class TeacherVC: WorkerVC {

    //MARK: Lifecycle
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 50.0, y: 50.0, width: 400.0, height: 300.0))
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        setupForm()
        
        if let person = object as? Person {
            self.view.window?.title = "\(person.firstName!) \(person.lastName!)"
        } else {
            self.view.window?.title = "New Teacher"
        }
    }
    
    override func validateInput() -> Bool {
        return super.validateInput()
    }
    
    override func okTapped() {
        guard validateInput() else {
            self.view.window?.close()
            return
        }
        
        var teacher: Teacher?
        
        switch action {
        case .create:
            teacher = DataModel.shared.emptyObject(name: Teacher.entityName) as? Teacher
        case .edit(let object):
            teacher = object as? Teacher
        case .preview(_): break
        }
        
        if let fetchedWorker = teacher {
            
            if let major = majorObject {
                fetchedWorker.majorID = major.uniqueID
            }
            
            switch action {
            case .create:
                DataModel.shared.insertObject(withModel: fetchedWorker)
                completion?(fetchedWorker)
            case .edit(_):
                completion?(fetchedWorker)
            case .preview(_): break
            }
        }
        
        self.view.window?.close()
    }
}
