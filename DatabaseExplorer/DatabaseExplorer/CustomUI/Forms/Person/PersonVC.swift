//
//  PersonVC.swift
//  DatabaseExplorer
//
//  Created by admin on 1/31/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//

import Cocoa

class PersonVC: FormVC {
    
    internal var firstNameLabel: NSTextField = {
        let label = NSTextField(string: "First Name:")
        label.isEditable = false
        label.isBordered = false
        label.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 1000), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    internal var lastNameLabel: NSTextField = {
        let label = NSTextField(string: "Last Name:")
        label.isEditable = false
        label.isBordered = false
        label.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 1000), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    internal var sexLabel: NSTextField = {
        let label = NSTextField(string: "Sex:")
        label.isEditable = false
        label.isBordered = false
        label.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 1000), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    internal var birthdayLabel: NSTextField = {
        let label = NSTextField(string: "Birthday:")
        label.isEditable = false
        label.isBordered = false
        label.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 1000), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    internal var firstNameTF: NSTextField = {
        let nameTF = NSTextField()
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        
        return nameTF
    }()
    
    internal var lastNameTF: NSTextField = {
        let textfield = NSTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        return textfield
    }()
    
    internal var sexPopUpButton: NSPopUpButton = {
        let button = NSPopUpButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addItem(withTitle: "Male")
        button.addItem(withTitle: "Female")
        button.selectItem(at: 0)
        return button
    }()
    
    internal var birthdayPicker: NSDatePicker = {
        let picker = NSDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.dateValue = Date()
        return picker
    }()

    //MARK: Lifecycle
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 50.0, y: 50.0, width: 400.0, height: 300.0))
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        setupForm()
        self.view.window?.title = object?.name ?? "New Person"
    }
    
    //MARK: Overrides
    override func setupForm() {
        super.setupForm()
        
        guard let documentView = scrollView.documentView else {
            return
        }
        
        switch action {
        case .edit(let object), .preview(let object):
            if let personObject = object as? Person,
                let fName = personObject.firstName,
                let lName = personObject.lastName,
                let birthday = personObject.birthday {
                
                firstNameTF.stringValue = fName
                lastNameTF.stringValue = lName
                sexPopUpButton.selectItem(at: personObject.sex == true ? 0 : 1)
                birthdayPicker.dateValue = birthday as Date
                
                if action == .preview(object) {
                    firstNameTF.isEditable = false
                    lastNameTF.isEditable = false
                    sexPopUpButton.isEnabled = false
                    birthdayPicker.isEnabled = false
                }
            }
        default: break
        }
        
        contentView.addSubview(firstNameLabel)
        documentView.addConstraint(NSLayoutConstraint(item: firstNameLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 16.0))
        documentView.addConstraint(NSLayoutConstraint(item: firstNameLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 16.0))
        
        contentView.addSubview(lastNameLabel)
        
        documentView.addConstraint(NSLayoutConstraint(item: lastNameLabel, attribute: .leading, relatedBy: .equal, toItem: firstNameLabel, attribute: .leading, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: lastNameLabel, attribute: .top, relatedBy: .equal, toItem: firstNameLabel, attribute: .bottom, multiplier: 1.0, constant: 24.0))
        
        contentView.addSubview(sexLabel)
        
        documentView.addConstraint(NSLayoutConstraint(item: sexLabel, attribute: .leading, relatedBy: .equal, toItem: firstNameLabel, attribute: .leading, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: sexLabel, attribute: .top, relatedBy: .equal, toItem: lastNameLabel, attribute: .bottom, multiplier: 1.0, constant: 24.0))
        
        contentView.addSubview(birthdayLabel)
        
        documentView.addConstraint(NSLayoutConstraint(item: birthdayLabel, attribute: .leading, relatedBy: .equal, toItem: firstNameLabel, attribute: .leading, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: birthdayLabel, attribute: .top, relatedBy: .equal, toItem: sexLabel, attribute: .bottom, multiplier: 1.0, constant: 24.0))
        
        contentView.addSubview(firstNameTF)
        
        documentView.addConstraint(NSLayoutConstraint(item: firstNameTF, attribute: .leading, relatedBy: .equal, toItem: firstNameLabel, attribute: .trailing, multiplier: 1.0, constant: 24.0))
        documentView.addConstraint(NSLayoutConstraint(item: firstNameTF, attribute: .centerY, relatedBy: .equal, toItem: firstNameLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: firstNameTF, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 220.0))
        documentView.addConstraint(NSLayoutConstraint(item: firstNameTF, attribute: .height, relatedBy: .equal, toItem: firstNameLabel, attribute: .height, multiplier: 1.2, constant: 0.0))
        
        contentView.addSubview(lastNameTF)
        
        documentView.addConstraint(NSLayoutConstraint(item: lastNameTF, attribute: .centerX, relatedBy: .equal, toItem: firstNameTF, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: lastNameTF, attribute: .centerY, relatedBy: .equal, toItem: lastNameLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: lastNameTF, attribute: .width, relatedBy: .equal, toItem: firstNameTF, attribute: .width, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: lastNameTF, attribute: .height, relatedBy: .equal, toItem: lastNameLabel, attribute: .height, multiplier: 1.2, constant: 0.0))
        
        contentView.addSubview(sexPopUpButton)
        
        documentView.addConstraint(NSLayoutConstraint(item: sexPopUpButton, attribute: .leading, relatedBy: .equal, toItem: lastNameTF, attribute: .leading, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: sexPopUpButton, attribute: .centerY, relatedBy: .equal, toItem: sexLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: sexPopUpButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0))
        documentView.addConstraint(NSLayoutConstraint(item: sexPopUpButton, attribute: .height, relatedBy: .equal, toItem: sexLabel, attribute: .height, multiplier: 1.0, constant: 0.0))
        
        contentView.addSubview(birthdayPicker)
        
        documentView.addConstraint(NSLayoutConstraint(item: birthdayPicker, attribute: .leading, relatedBy: .equal, toItem: sexPopUpButton, attribute: .leading, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: birthdayPicker, attribute: .centerY, relatedBy: .equal, toItem: birthdayLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: birthdayPicker, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0))
        documentView.addConstraint(NSLayoutConstraint(item: birthdayPicker, attribute: .height, relatedBy: .equal, toItem: birthdayLabel, attribute: .height, multiplier: 1.0, constant: 0.0))
        
        
        self.lastUIElement = birthdayLabel
    }
    
    override func validateInput() -> Bool {
        return firstNameTF.stringValue.count > 0 && lastNameTF.stringValue.count > 0
    }
    
    override func okTapped() {
        guard validateInput() else {
            self.view.window?.close()
            return
        }
        
        var person: Person?
        
        switch action {
        case .create:
            person = DataModel.shared.emptyObject(name: Person.entityName) as? Person
        case .edit(let object):
            person = object as? Person
        case .preview(_): break
        }
        
        if let fetchedPerson = person {
            fetchedPerson.firstName = firstNameTF.stringValue
            fetchedPerson.lastName = lastNameTF.stringValue
            fetchedPerson.sex = sexPopUpButton.indexOfSelectedItem == 0 ? true : false
            fetchedPerson.birthday = birthdayPicker.dateValue as NSDate
            
            if let major = majorObject {
                fetchedPerson.majorID = major.uniqueID
            }
            
            switch action {
            case .create:
                DataModel.shared.insertObject(withModel: fetchedPerson)
            case .edit(_), .preview(_): break
            }
        }
        
        self.view.window?.close()
    }
}
