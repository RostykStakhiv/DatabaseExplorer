//
//  EducationalDepartment+CoreDataClass.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/15/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData

@objc(EducationalDepartment)
public class EducationalDepartment: Building {
    
    //MARK: Overrides
    override class var humanReadableEntityName: String {
        get {
            return "Educational Department"
        }
    }
    
    override class var entityName: String {
        get {
            return "EducationalDepartment"
        }
    }

}
