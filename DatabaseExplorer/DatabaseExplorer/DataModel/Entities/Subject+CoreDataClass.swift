//
//  Subject+CoreDataClass.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/15/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Subject)
public class Subject: Object {
    
    //MARK: Overrides
    override class var humanReadableEntityName: String {
        get {
            return "Subject"
        }
    }

}
