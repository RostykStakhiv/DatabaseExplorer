//
//  University+CoreDataClass.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/15/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData

@objc(University)
public class University: Building {
    
    //MARK: Overrides
    override class var humanReadableEntityName: String {
        get {
            return "University"
        }
    }
    
    override func parseWithModel(_ model: Object) -> Bool {
        guard super.parseWithModel(model), let universityModel = model as? University else {
            return false
        }
        
        self.faculties = universityModel.faculties
        
        return true
    }
}
