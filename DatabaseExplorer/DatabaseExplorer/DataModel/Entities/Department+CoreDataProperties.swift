//
//  Department+CoreDataProperties.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/15/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData


extension Department {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Department> {
        return NSFetchRequest<Department>(entityName: "Department")
    }

    @NSManaged public var faculty: Faculty?
    @NSManaged public var subjects: NSSet?

}

// MARK: Generated accessors for subjects
extension Department {

    @objc(addSubjectsObject:)
    @NSManaged public func addToSubjects(_ value: Subject)

    @objc(removeSubjectsObject:)
    @NSManaged public func removeFromSubjects(_ value: Subject)

    @objc(addSubjects:)
    @NSManaged public func addToSubjects(_ values: NSSet)

    @objc(removeSubjects:)
    @NSManaged public func removeFromSubjects(_ values: NSSet)

}
