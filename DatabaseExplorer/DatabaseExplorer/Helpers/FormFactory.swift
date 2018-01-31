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
        
        let classStr = objectType != nil ? String(describing: objectType!) : String(describing: type(of: object!))
        var formWC: FormWC?
        
        if classStr == String(describing: University.self) {
            formWC = UniversityFormWC()
        } else if classStr == String(describing: Faculty.self) {
            formWC = FacultyWC()
        } else if classStr == String(describing: Department.self) {
            formWC = DepartmentWC()
        } else if classStr == String(describing: Person.self) {
            formWC = PersonWC()
        } else if classStr == String(describing: Worker.self) {
            formWC = WorkerWC()
        } else if classStr == String(describing: Teacher.self) {
            formWC = TeacherWC()
        }
        
        return formWC
    }
}
