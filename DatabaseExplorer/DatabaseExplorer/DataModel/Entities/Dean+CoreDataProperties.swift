//
//  Dean+CoreDataProperties.swift
//  DatabaseExplorer
//
//  Created by admin on 1/31/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData


extension Dean {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dean> {
        return NSFetchRequest<Dean>(entityName: "Dean")
    }

    @NSManaged public var faculty: Faculty?

}
