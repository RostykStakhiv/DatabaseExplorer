//
//  Object+CoreDataProperties.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/15/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData


extension Object {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Object> {
        return NSFetchRequest<Object>(entityName: "Object")
    }

    @NSManaged public var createDate: NSDate?
    @NSManaged public var majorID: Int64
    @NSManaged public var name: String?
    @NSManaged public var uniqueID: Int64

}
