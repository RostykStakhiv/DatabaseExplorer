//
//  UniversityFromWC.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/26/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//

import Cocoa

class UniversityFormWC: FormWC {
    
    convenience init() {
        let contentController = UniversityFormVC(nibName: nil, bundle: nil)
        let window = NSWindow(contentViewController: contentController)
        self.init(window: window)
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        
    }
}
