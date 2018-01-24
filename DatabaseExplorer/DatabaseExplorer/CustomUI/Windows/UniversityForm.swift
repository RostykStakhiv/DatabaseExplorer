//
//  UniversityForm.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/23/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//

import Cocoa

class UniversityForm: FormVC {
    
    var nameTextField: NSTextField = NSTextField(string: "Name")

    //MARK: Lifecycle
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 50.0, y: 50.0, width: 600.0, height: 500.0))
        setupForm()
    }
    
    //MARK: Overrides
    override func setupForm() {
        super.setupForm()
        
        guard let documentView = scrollView.documentView else {
            return
        }
        
        contentView.addSubview(nameTextField)
        nameTextField.isEditable = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        documentView.addConstraint(NSLayoutConstraint(item: nameTextField, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 16.0))
        //documentView.addConstraint(NSLayoutConstraint(item: nameTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 16.0))
        documentView.addConstraint(NSLayoutConstraint(item: nameTextField, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 16.0))
        //documentView.addConstraint(NSLayoutConstraint(item: nameTextField, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 16.0))
        nameTextField.addConstraint(NSLayoutConstraint(item: nameTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 24.0))
    }
    
}
