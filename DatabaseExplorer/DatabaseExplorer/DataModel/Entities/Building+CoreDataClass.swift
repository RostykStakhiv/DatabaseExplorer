//
//  Building+CoreDataClass.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/15/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Building)
public class Building: Object {
    
    //MARK: Overrides
    override class var humanReadableEntityName: String {
        get {
            return "Building"
        }
    }
    
    override class var entityName: String {
        get {
            return "Building"
        }
    }
    
    override func parseWithModel(_ model: Object) -> Bool {
        guard super.parseWithModel(model), let buildingModel = model as? Building else {
            return false
        }
        
        self.address = buildingModel.address
        
        return true
    }
}
