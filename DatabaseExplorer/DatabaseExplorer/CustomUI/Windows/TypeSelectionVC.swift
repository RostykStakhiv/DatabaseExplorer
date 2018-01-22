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
    
    private var types = [Object.Type]()
    
    var majorObject: Object?
    var completion: ((_ selectedType: Object.Type) -> Void)?

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTypes()
        setupTypesPopUpButton()
    }
    
    //MARK: Private Methods
    private func setupTypesPopUpButton() {
        for type in types {
            let humanReadableName = type.humanReadableEntityName
            typesPopUpButton.addItem(withTitle: humanReadableName)
        }
    }
    
    private func setupTypes() {
        if let major = majorObject {
            if major is University {
                types = [Faculty.self, Worker.self]
            }
        } else {
            types = [University.self, Worker.self, EducationalDepartment.self]
        }
    }
    
    //MARK: IBActions
    @IBAction func okTapped(_ sender: NSButton) {
        let selectedType = types[typesPopUpButton.indexOfSelectedItem]
        completion?(selectedType)
        NSApplication.shared.stopModal()
    }
    
    @IBAction func cancelTapped(_ sender: NSButton) {
        NSApplication.shared.stopModal()
    }
    
}
