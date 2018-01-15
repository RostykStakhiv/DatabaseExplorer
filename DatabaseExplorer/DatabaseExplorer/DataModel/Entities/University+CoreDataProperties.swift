//
//  University+CoreDataProperties.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/15/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData


extension University {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<University> {
        return NSFetchRequest<University>(entityName: "University")
    }

    @NSManaged public var faculties: NSSet?

}

// MARK: Generated accessors for faculties
extension University {

    @objc(addFacultiesObject:)
    @NSManaged public func addToFaculties(_ value: Faculty)

    @objc(removeFacultiesObject:)
    @NSManaged public func removeFromFaculties(_ value: Faculty)

    @objc(addFaculties:)
    @NSManaged public func addToFaculties(_ values: NSSet)

    @objc(removeFaculties:)
    @NSManaged public func removeFromFaculties(_ values: NSSet)

}
