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
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Overrides
    override func setupForm() {
        super.setupForm()
        
        contentView.addSubview(nameTextField)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: nameTextField,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: contentView,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: 16.0).isActive = true
        
        NSLayoutConstraint(item: nameTextField,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: contentView,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 24.0).isActive = true
//        infoButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 8).isActive = true
//        infoButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -8).isActive = true
//        infoButton.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.08).isActive = true
//        infoButton.heightAnchor.constraint(equalTo: infoButton.widthAnchor, multiplier: 1).isActive = true
    }
    
}
