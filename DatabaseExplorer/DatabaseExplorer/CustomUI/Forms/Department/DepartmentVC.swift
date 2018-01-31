//
//  DepartmentVC.swift
//  DatabaseExplorer
//
//  Created by admin on 1/31/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//

import Cocoa

class DepartmentVC: FormVC {
    
    internal var tempHeadTeacher: Teacher?
    
    internal var departmentNameLabel: NSTextField = {
        let label = NSTextField(string: "Department Name:")
        label.isEditable = false
        label.isBordered = false
        label.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 1000), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    internal var teacherLabel: NSTextField = {
        let label = NSTextField(string: "Teacher:")
        label.isEditable = false
        label.isBordered = false
        label.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 1000), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    internal var teacherNameLabel: NSTextField = {
        let label = NSTextField(string: "")
        label.isEditable = false
        label.isBordered = false
        label.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 1000), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    internal var nameTF: NSTextField = {
        let nameTF = NSTextField()
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        
        return nameTF
    }()
    
    internal var editTeacherButton: NSButton = {
        let button = NSButton(title: "Edit", target: self, action: #selector(handleEditButton))
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    //MARK: Lifecycle
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 50.0, y: 50.0, width: 400.0, height: 150.0))
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        setupForm()
        self.view.window?.title = object?.name ?? "New Department"
    }
    
    //MARK: Overrides
    override func setupForm() {
        super.setupForm()
        
        guard let documentView = scrollView.documentView else {
            return
        }
        
        switch action {
        case .edit(let object), .preview(let object):
            if let departmentObject = object as? Department,
                let name = departmentObject.name,
                let teacher = departmentObject.headTeacher {
                
                nameTF.stringValue = name
                teacherNameLabel.stringValue = "\(teacher.firstName!) \(teacher.lastName!)"
                tempHeadTeacher = teacher
                
                if action == .preview(object) {
                    nameTF.isEditable = false
                    editTeacherButton.isEnabled = false
                }
            }
        default: break
        }
        
        contentView.addSubview(departmentNameLabel)
        documentView.addConstraint(NSLayoutConstraint(item: departmentNameLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 16.0))
        documentView.addConstraint(NSLayoutConstraint(item: departmentNameLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 16.0))
        
        contentView.addSubview(teacherLabel)
        
        documentView.addConstraint(NSLayoutConstraint(item: teacherLabel, attribute: .leading, relatedBy: .equal, toItem: departmentNameLabel, attribute: .leading, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: teacherLabel, attribute: .top, relatedBy: .equal, toItem: departmentNameLabel, attribute: .bottom, multiplier: 1.0, constant: 24.0))
        
        contentView.addSubview(teacherNameLabel)
        
        documentView.addConstraint(NSLayoutConstraint(item: teacherNameLabel, attribute: .leading, relatedBy: .equal, toItem: teacherLabel, attribute: .trailing, multiplier: 1.0, constant: 24.0))
        documentView.addConstraint(NSLayoutConstraint(item: teacherNameLabel, attribute: .centerY, relatedBy: .equal, toItem: teacherLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        contentView.addSubview(editTeacherButton)
        
        documentView.addConstraint(NSLayoutConstraint(item: editTeacherButton, attribute: .leading, relatedBy: .equal, toItem: teacherLabel, attribute: .leading, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: editTeacherButton, attribute: .top, relatedBy: .equal, toItem: teacherLabel, attribute: .bottom, multiplier: 1.0, constant: 24.0))
        
        contentView.addSubview(nameTF)
        
        documentView.addConstraint(NSLayoutConstraint(item: nameTF, attribute: .leading, relatedBy: .equal, toItem: departmentNameLabel, attribute: .trailing, multiplier: 1.0, constant: 24.0))
        documentView.addConstraint(NSLayoutConstraint(item: nameTF, attribute: .centerY, relatedBy: .equal, toItem: departmentNameLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: nameTF, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 220.0))
        documentView.addConstraint(NSLayoutConstraint(item: nameTF, attribute: .height, relatedBy: .equal, toItem: departmentNameLabel, attribute: .height, multiplier: 1.2, constant: 0.0))
        
        
        self.lastUIElement = editTeacherButton
        self.addButtons([okButton, cancelButton])
    }
    
    override func validateInput() -> Bool {
        return departmentNameLabel.stringValue.count > 0 && tempHeadTeacher != nil
    }
    
    override func okTapped() {
        guard validateInput() else {
            self.view.window?.close()
            return
        }
        
        var department: Department?
        
        switch action {
        case .create:
            department = DataModel.shared.emptyObject(name: Department.entityName) as? Department
        case .edit(let object):
            department = object as? Department
        case .preview(_): break
        }
        
        if let fetchedDepartment = department {
            fetchedDepartment.name = nameTF.stringValue
            fetchedDepartment.headTeacher = tempHeadTeacher!
            
            if let major = majorObject {
                fetchedDepartment.majorID = major.uniqueID
            }
            
            switch action {
            case .create:
                DataModel.shared.insertObject(withModel: fetchedDepartment)
            case .edit(_), .preview(_): break
            }
        }
        
        self.view.window?.close()
    }
    
    //MARK: Private handlers
    @objc private func handleEditButton() {
        
    }
    
}
