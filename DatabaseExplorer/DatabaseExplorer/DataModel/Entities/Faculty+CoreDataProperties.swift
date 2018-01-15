//
//  Faculty+CoreDataProperties.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/15/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData


extension Faculty {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Faculty> {
        return NSFetchRequest<Faculty>(entityName: "Faculty")
    }

    @NSManaged public var departments: NSSet?
    @NSManaged public var students: NSSet?
    @NSManaged public var university: University?

}

// MARK: Generated accessors for departments
extension Faculty {

    @objc(addDepartmentsObject:)
    @NSManaged public func addToDepartments(_ value: Department)

    @objc(removeDepartmentsObject:)
    @NSManaged public func removeFromDepartments(_ value: Department)

    @objc(addDepartments:)
    @NSManaged public func addToDepartments(_ values: NSSet)

    @objc(removeDepartments:)
    @NSManaged public func removeFromDepartments(_ values: NSSet)

}

// MARK: Generated accessors for students
extension Faculty {

    @objc(addStudentsObject:)
    @NSManaged public func addToStudents(_ value: Student)

    @objc(removeStudentsObject:)
    @NSManaged public func removeFromStudents(_ value: Student)

    @objc(addStudents:)
    @NSManaged public func addToStudents(_ values: NSSet)

    @objc(removeStudents:)
    @NSManaged public func removeFromStudents(_ values: NSSet)

}
