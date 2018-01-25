//
//  FormFactory.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/19/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//

import Cocoa

class FormFactory {

    class func createForm(forObjectType type: Object.Type) -> NSWindowController {
        var formVC: FormVC?
        
        if type == University.self {
            formVC = UniversityForm(nibName: nil, bundle: nil)
        } else if type == Student.self {
            
        }
        
        if let formViewController = formVC {
            let window = NSWindow(contentViewController: formViewController)
            window.title = type.humanReadableEntityName
            let formWindowController = NSWindowController(window: window)
            return formWindowController
        }
        
        return NSWindowController()
    }
}
