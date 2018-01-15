//
//  EducationalDepartment+CoreDataProperties.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/15/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData


extension EducationalDepartment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EducationalDepartment> {
        return NSFetchRequest<EducationalDepartment>(entityName: "EducationalDepartment")
    }

    @NSManaged public var email: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var webSiteURL: String?

}
