//
//  FormFactory.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/19/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//

import Cocoa

class FormFactory {

    class func createForm(forObjectType objectType: Object.Type? = nil, object: Object? = nil) -> FormWC? {
        guard objectType != nil || object != nil else {
            return nil
        }
        
        let typeOfObject = objectType ?? type(of: object!)
        var formWC: FormWC?
        
        if typeOfObject.objectSpecifier() == University.self.objectSpecifier() {
            formWC = UniversityFormWC()
        } else if typeOfObject == Student.self {
            
        } else if typeOfObject == Object.Type.self {
            print("Object")
        } else {
            print(University.self)
        }
        
        return formWC
    }
}
