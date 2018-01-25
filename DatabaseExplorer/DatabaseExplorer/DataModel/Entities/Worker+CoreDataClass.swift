//
//  Worker+CoreDataClass.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/15/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Worker)
public class Worker: Person {
    
    //MARK: Overrides
    override class var humanReadableEntityName: String {
        get {
            return "Worker"
        }
    }
    
    override class var entityName: String {
        get {
            return "Worker"
        }
    }
}
