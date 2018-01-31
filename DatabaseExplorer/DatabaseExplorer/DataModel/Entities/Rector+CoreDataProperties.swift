//
//  Rector+CoreDataProperties.swift
//  DatabaseExplorer
//
//  Created by admin on 1/31/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData


extension Rector {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rector> {
        return NSFetchRequest<Rector>(entityName: "Rector")
    }

    @NSManaged public var university: University?

}
