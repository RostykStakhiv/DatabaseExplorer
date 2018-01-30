//
//  Address+CoreDataProperties.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/26/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData


extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }

    @NSManaged public var formattedAddress: String?
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var building: Building?

}
