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
            formViewController.view = NSView(frame: NSRect(x: 50.0, y: 50.0, width: 400.0, height: 600.0))
            formViewController.setupForm()
            let formWindowController = NSWindowController(window: NSWindow(contentViewController: formViewController))
            return formWindowController
        }
        
        return NSWindowController()
    }
}
