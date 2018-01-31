//
//  WorkerWC.swift
//  DatabaseExplorer
//
//  Created by admin on 1/31/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//

import Cocoa

class WorkerWC: PersonWC {
    
    convenience init() {
        let contentController = WorkerVC(nibName: nil, bundle: nil)
        let window = NSWindow(contentViewController: contentController)
        self.init(window: window)
    }

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
