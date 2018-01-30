//
//  FacultyVC.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/30/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//

import Cocoa

class FacultyVC: FormVC {
    
    internal lazy var nameLbl: NSTextField = {
        let label = NSTextField(string: "Faculty Name:")
        label.isEditable = false
        label.isBordered = false
        label.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 1000), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    internal lazy var emailLbl: NSTextField = {
        let label = NSTextField(string: "Email:")
        label.isEditable = false
        label.isBordered = false
        label.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 1000), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    internal lazy var phonelLbl: NSTextField = {
        let label = NSTextField(string: "Phone Number:")
        label.isEditable = false
        label.isBordered = false
        label.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 1000), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    internal lazy var webSiteURLLbl: NSTextField = {
        let label = NSTextField(string: "Web Site URL:")
        label.isEditable = false
        label.isBordered = false
        label.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 1000), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    internal lazy var nameTF: NSTextField = {
        let textField = NSTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    internal lazy var emailTF: NSTextField = {
        let textField = NSTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    internal lazy var phoneTF: NSTextField = {
        let textField = NSTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    internal lazy var websiteTF: NSTextField = {
        let textField = NSTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()

    //MARK: Lifecycle
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 50.0, y: 50.0, width: 400.0, height: 300.0))
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        setupForm()
        self.view.window?.title = object?.name ?? "New Faculty"
    }
    
    //MARK: Overrides
    override func setupForm() {
        super.setupForm()
        
        guard let documentView = scrollView.documentView else {
            return
        }
        
        switch action {
        case .edit(let object), .preview(let object):
            if let faculty = object as? Faculty,
                let name = faculty.name,
                let email = faculty.email,
                let phone = faculty.phoneNumber,
                let webSiteURL = faculty.webSiteURL {
                
                nameTF.stringValue = name
                emailTF.stringValue = email
                phoneTF.stringValue = phone
                websiteTF.stringValue = webSiteURL
                
                if action == .preview(object) {
                    nameTF.isEditable = false
                    emailTF.isEditable = false
                    phoneTF.isEditable = false
                    websiteTF.isEditable = false
                }
            }
        default: break
        }
        
        contentView.addSubview(nameLbl)
        documentView.addConstraint(NSLayoutConstraint(item: nameLbl, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 16.0))
        documentView.addConstraint(NSLayoutConstraint(item: nameLbl, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 16.0))
        
        contentView.addSubview(emailLbl)
        
        documentView.addConstraint(NSLayoutConstraint(item: emailLbl, attribute: .leading, relatedBy: .equal, toItem: nameLbl, attribute: .leading, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: emailLbl, attribute: .top, relatedBy: .equal, toItem: nameLbl, attribute: .bottom, multiplier: 1.0, constant: 24.0))
        
        contentView.addSubview(phonelLbl)
        
        documentView.addConstraint(NSLayoutConstraint(item: phonelLbl, attribute: .leading, relatedBy: .equal, toItem: nameLbl, attribute: .leading, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: phonelLbl, attribute: .top, relatedBy: .equal, toItem: emailLbl, attribute: .bottom, multiplier: 1.0, constant: 24.0))
        
        contentView.addSubview(webSiteURLLbl)
        
        documentView.addConstraint(NSLayoutConstraint(item: webSiteURLLbl, attribute: .leading, relatedBy: .equal, toItem: nameLbl, attribute: .leading, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: webSiteURLLbl, attribute: .top, relatedBy: .equal, toItem: phonelLbl, attribute: .bottom, multiplier: 1.0, constant: 24.0))
        
        contentView.addSubview(nameTF)
        
        documentView.addConstraint(NSLayoutConstraint(item: nameTF, attribute: .leading, relatedBy: .equal, toItem: nameLbl, attribute: .trailing, multiplier: 1.0, constant: 24.0))
        documentView.addConstraint(NSLayoutConstraint(item: nameTF, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 24.0))
        documentView.addConstraint(NSLayoutConstraint(item: nameTF, attribute: .centerY, relatedBy: .equal, toItem: nameLbl, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: nameTF, attribute: .height, relatedBy: .equal, toItem: nameLbl, attribute: .height, multiplier: 1.2, constant: 0.0))
        
        contentView.addSubview(emailTF)
        
        documentView.addConstraint(NSLayoutConstraint(item: emailTF, attribute: .centerX, relatedBy: .equal, toItem: nameTF, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: emailTF, attribute: .width, relatedBy: .equal, toItem: nameTF, attribute: .width, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: emailTF, attribute: .centerY, relatedBy: .equal, toItem: emailLbl, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: emailTF, attribute: .height, relatedBy: .equal, toItem: emailLbl, attribute: .height, multiplier: 1.2, constant: 0.0))
        
        contentView.addSubview(phoneTF)
        
        documentView.addConstraint(NSLayoutConstraint(item: phoneTF, attribute: .centerX, relatedBy: .equal, toItem: emailTF, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: phoneTF, attribute: .width, relatedBy: .equal, toItem: emailTF, attribute: .width, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: phoneTF, attribute: .centerY, relatedBy: .equal, toItem: phonelLbl, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: phoneTF, attribute: .height, relatedBy: .equal, toItem: phonelLbl, attribute: .height, multiplier: 1.2, constant: 0.0))
        
        contentView.addSubview(websiteTF)
        
        documentView.addConstraint(NSLayoutConstraint(item: websiteTF, attribute: .centerX, relatedBy: .equal, toItem: phoneTF, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: websiteTF, attribute: .width, relatedBy: .equal, toItem: phoneTF, attribute: .width, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: websiteTF, attribute: .centerY, relatedBy: .equal, toItem: webSiteURLLbl, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: websiteTF, attribute: .height, relatedBy: .equal, toItem: webSiteURLLbl, attribute: .height, multiplier: 1.2, constant: 0.0))
        
        self.lastUIElement = websiteTF
        self.addButtons([okButton, cancelButton])
    }
    
    override func validateInput() -> Bool {
        return false
    }
    
}
