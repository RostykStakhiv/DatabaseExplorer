//
//  WorkerVC.swift
//  DatabaseExplorer
//
//  Created by admin on 1/31/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//

import Cocoa

class WorkerVC: PersonVC {
    
    private var salary: Double = 0.0
    
    internal var positionLabel: NSTextField = {
        let label = NSTextField(string: "Position:")
        label.isEditable = false
        label.isBordered = false
        label.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 1000), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    internal var salaryLabel: NSTextField = {
        let label = NSTextField(string: "Salary:")
        label.isEditable = false
        label.isBordered = false
        label.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 1000), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    internal var positionTF: NSTextField = {
        let textfield = NSTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        return textfield
    }()
    
    internal var salaryTF: NSTextField = {
        let textfield = NSTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        return textfield
    }()

    //MARK: Lifecycle
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 50.0, y: 50.0, width: 400.0, height: 300.0))
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        setupForm()
        
        if let person = object as? Person {
            self.view.window?.title = "\(person.firstName) \(person.lastName)"
        } else {
            self.view.window?.title = "New Worker"
        }
    }
    
    //MARK: Overrides
    override func setupForm() {
        super.setupForm()
        
        guard let documentView = scrollView.documentView else {
            return
        }
        
        switch action {
        case .edit(let object), .preview(let object):
            if let castedObject = object as? Worker,
                let position = castedObject.position {
                
                positionTF.stringValue = position
                self.salary = castedObject.salary
                salaryTF.stringValue = String(describing: self.salary)
                
                if action == .preview(object) {
                    positionTF.isEditable = false
                    salaryTF.isEnabled = false
                }
            }
        default: break
        }
        
        contentView.addSubview(positionLabel)
        documentView.addConstraint(NSLayoutConstraint(item: positionLabel, attribute: .leading, relatedBy: .equal, toItem: super.lastUIElement, attribute: .leading, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: positionLabel, attribute: .top, relatedBy: .equal, toItem: super.lastUIElement, attribute: .bottom, multiplier: 1.0, constant: 24.0))
        
        contentView.addSubview(salaryLabel)
        
        documentView.addConstraint(NSLayoutConstraint(item: salaryLabel, attribute: .leading, relatedBy: .equal, toItem: positionLabel, attribute: .leading, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: salaryLabel, attribute: .top, relatedBy: .equal, toItem: positionLabel, attribute: .bottom, multiplier: 1.0, constant: 24.0))
        
        contentView.addSubview(positionTF)
        
        documentView.addConstraint(NSLayoutConstraint(item: positionTF, attribute: .leading, relatedBy: .equal, toItem: positionLabel, attribute: .trailing, multiplier: 1.0, constant: 24.0))
        documentView.addConstraint(NSLayoutConstraint(item: positionTF, attribute: .centerY, relatedBy: .equal, toItem: positionLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: positionTF, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 220.0))
        documentView.addConstraint(NSLayoutConstraint(item: positionTF, attribute: .height, relatedBy: .equal, toItem: positionLabel, attribute: .height, multiplier: 1.2, constant: 0.0))
        
        contentView.addSubview(salaryTF)
        
        documentView.addConstraint(NSLayoutConstraint(item: salaryTF, attribute: .leading, relatedBy: .equal, toItem: positionTF, attribute: .leading, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: salaryTF, attribute: .centerY, relatedBy: .equal, toItem: salaryLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: salaryTF, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 120.0))
        documentView.addConstraint(NSLayoutConstraint(item: salaryTF, attribute: .height, relatedBy: .equal, toItem: salaryLabel, attribute: .height, multiplier: 1.2, constant: 0.0))
        
        self.addButtons([okButton, cancelButton])
    }
    
    override var lastUIElement: AnyObject? {
        get {
            return salaryTF
        }
    }
    
    override func validateInput() -> Bool {
        self.salary = Double(salaryTF.stringValue) ?? 0
        return positionTF.stringValue.count > 0 && self.salary > 0
    }
    
    override func okTapped() {
        guard validateInput() else {
            self.view.window?.close()
            return
        }
        
        var worker: Worker?
        
        switch action {
        case .create:
            worker = DataModel.shared.emptyObject(name: Worker.entityName) as? Worker
        case .edit(let object):
            worker = object as? Worker
        case .preview(_): break
        }
        
        if let fetchedWorker = worker {
            fetchedWorker.position = positionTF.stringValue
            fetchedWorker.salary = Double(salaryTF.stringValue) ?? 0
            
            if let major = majorObject {
                fetchedWorker.majorID = major.uniqueID
            }
            
            switch action {
            case .create:
                DataModel.shared.insertObject(withModel: fetchedWorker)
                completion?(fetchedWorker)
            case .edit(_):
                completion?(fetchedWorker)
            case .preview(_): break
            }
        }
        
        self.view.window?.close()
    }
    
}
