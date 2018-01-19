//
//  Person+CoreDataClass.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/15/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: Object {
    
    //MARK: Overrides
    override class var humanReadableEntityName: String {
        get {
            return "Person"
        }
    }

    override func parseWithModel(_ model: Object) -> Bool {
        guard super.parseWithModel(model), let personModel = model as? Person else {
            return false
        }
        
        self.firstName = personModel.firstName
        self.lastName = personModel.lastName
        self.sex = personModel.sex
        
        return true
    }
}
