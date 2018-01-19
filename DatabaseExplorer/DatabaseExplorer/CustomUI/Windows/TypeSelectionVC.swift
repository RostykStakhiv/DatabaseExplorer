//
//  TypeSelectionVC.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/19/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//

import Cocoa

class TypeSelectionVC: NSViewController {
    
    @IBOutlet private weak var typesPopUpButton: NSPopUpButton!
    
    var majorObject: Object?

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Private Methods
    private func setupTypesPopUpButton() {
        if let major = majorObject {
            
        } else {
            
        }
    }
    
    //MARK: IBActions
    @IBAction func okTapped(_ sender: NSButton) {
        
    }
    
}
