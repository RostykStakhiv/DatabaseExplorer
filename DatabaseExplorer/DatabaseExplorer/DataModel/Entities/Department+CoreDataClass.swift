//
//  Department+CoreDataClass.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/15/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Department)
public class Department: Object {
    
    //MARK: Overrides
    override class var humanReadableEntityName: String {
        get {
            return "Department"
        }
    }
    
    override class var entityName: String {
        get {
            return "Department"
        }
    }

}
