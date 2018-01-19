//
//  College+CoreDataClass.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/15/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData

@objc(College)
public class College: EducationalDepartment {
    
    //MARK: Overrides
    override class var humanReadableEntityName: String {
        get {
            return "College"
        }
    }

}
