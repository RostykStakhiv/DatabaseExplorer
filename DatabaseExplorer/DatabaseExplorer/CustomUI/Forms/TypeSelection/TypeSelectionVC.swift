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
    var completion: FormPresenter.TypeSelectionFormCompletion?

    //MARK: Lifecycle
    override func viewWillAppear() {
        super.viewWillAppear()
        
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
                types = [Faculty.self, Person.self]
            } else if major is Faculty {
                types = [Department.self]
            } else if major is Department {
                types = [Group.self]
            }
        } else {
            types = [University.self, Worker.self, EducationalDepartment.self]
        }
    }
    
    //MARK: IBActions
    @IBAction func okTapped(_ sender: NSButton) {
        let selectedType = types[typesPopUpButton.indexOfSelectedItem]
        completion?(selectedType)
        self.view.window?.close()
    }
    
    @IBAction func cancelTapped(_ sender: NSButton) {
        self.view.window?.close()
    }
    
}
