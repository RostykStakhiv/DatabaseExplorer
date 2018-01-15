//
//  Address+CoreDataProperties.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/15/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData


extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }

    @NSManaged public var formattedAddress: Int64
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var building: Building?

}
