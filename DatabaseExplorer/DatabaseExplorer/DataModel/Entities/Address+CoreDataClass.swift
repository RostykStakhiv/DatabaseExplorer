//
//  Address+CoreDataClass.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/15/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Address)
public class Address: NSManagedObject {
    
    class var entityName: String {
        get {
            return "Address"
        }
    }
    
//    override func parseWithModel(_ model: Object) -> Bool {
//        guard super.parseWithModel(model), let addressModel = model as? Address else {
//            return false
//        }
//        
//        self.formattedAddress = addressModel.formattedAddress
//        self.lat = addressModel.lat
//        self.lng = addressModel.lng
//        self.building = addressModel.building
//        
//        return true
//    }
}
