//
//  Teacher+CoreDataClass.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/15/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Teacher)
public class Teacher: Worker {
    
    //MARK: Overrides
    override class var humanReadableEntityName: String {
        get {
            return "Teacher"
        }
    }

    override class var entityName: String {
        get {
            return "Teacher"
        }
    }
}
