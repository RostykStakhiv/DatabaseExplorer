//
//  UniversityForm.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/23/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//

import Cocoa

class UniversityFormVC: FormVC {
    
    internal var nameLabel: NSTextField = {
        let label = NSTextField(string: "University Name:")
        label.isEditable = false
        label.isBordered = false
        label.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 1000), for: .horizontal)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    internal var addressLabel: NSTextField = {
        let label = NSTextField(string: "Address:")
        label.isEditable = false
        label.isBordered = false
        label.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 1000), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    internal var addressLatLbl: NSTextField = {
        let label = NSTextField(string: "Address Lat:")
        label.isEditable = false
        label.isBordered = false
        label.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 1000), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    internal var addressLngLbl: NSTextField = {
        let label = NSTextField(string: "Address Lng:")
        label.isEditable = false
        label.isBordered = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 1000), for: .horizontal)
        
        return label
    }()
    
    internal var universityNameTF: NSTextField = {
        let nameTF = NSTextField()
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        
        return nameTF
    }()
    
    internal var addressTF: NSTextField = {
        let addressTF = NSTextField()
        addressTF.translatesAutoresizingMaskIntoConstraints = false
        
        return addressTF
    }()
    
    internal var addressLatTF: NSTextField = {
        let addressLatTF = NSTextField()
        addressLatTF.translatesAutoresizingMaskIntoConstraints = false
        
        return addressLatTF
    }()
    
    internal var addressLngTF: NSTextField = {
        let addressLngTF = NSTextField()
        addressLngTF.translatesAutoresizingMaskIntoConstraints = false
        
        return addressLngTF
    }()
    
    private var okButton: NSButton = {
        let ok = NSButton(title: "OK", target: self, action: #selector(okTapped))
        ok.keyEquivalent = "\r"
        return ok
    }()
    
    private var cancelButton: NSButton = {
        let cancel = NSButton(title: "Cancel", target: self, action: #selector(cancelTapped))
        return cancel
    }()

    //MARK: Lifecycle
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 50.0, y: 50.0, width: 400.0, height: 300.0))
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        setupForm()
        self.view.window?.title = object?.name ?? "New University"
    }
    
    //MARK: Overrides
    override func setupForm() {
        super.setupForm()
        
        guard let documentView = scrollView.documentView else {
            return
        }
        
        contentView.addSubview(nameLabel)
        documentView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 16.0))
        documentView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 16.0))
        
        switch action {
        case .edit(let object), .preview(let object):
            if let university = object as? University,
                let unName = university.name,
                let unAddress = university.address?.formattedAddress,
                let lat = university.address?.lat,
                let lng = university.address?.lng {
                
                universityNameTF.stringValue = unName
                addressTF.stringValue = unAddress
                addressLatTF.stringValue = String(describing: lat)
                addressLngTF.stringValue = String(describing: lng)
                
                if action == .preview(object) {
                    universityNameTF.isEditable = false
                    addressTF.isEditable = false
                    addressLatTF.isEditable = false
                    addressLngTF.isEditable = false
                }
            }
        default: break
        }
        
        contentView.addSubview(universityNameTF)
        
        documentView.addConstraint(NSLayoutConstraint(item: universityNameTF, attribute: .leading, relatedBy: .equal, toItem: nameLabel, attribute: .trailing, multiplier: 1.0, constant: 24.0))
        documentView.addConstraint(NSLayoutConstraint(item: universityNameTF, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 24.0))
        documentView.addConstraint(NSLayoutConstraint(item: universityNameTF, attribute: .centerY, relatedBy: .equal, toItem: nameLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: universityNameTF, attribute: .height, relatedBy: .equal, toItem: nameLabel, attribute: .height, multiplier: 1.2, constant: 0.0))
        
        contentView.addSubview(addressLabel)
        
        documentView.addConstraint(NSLayoutConstraint(item: addressLabel, attribute: .leading, relatedBy: .equal, toItem: nameLabel, attribute: .leading, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: addressLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1.0, constant: 24.0))
        
        contentView.addSubview(addressTF)
        
        documentView.addConstraint(NSLayoutConstraint(item: addressTF, attribute: .centerX, relatedBy: .equal, toItem: universityNameTF, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: addressTF, attribute: .width, relatedBy: .equal, toItem: universityNameTF, attribute: .width, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: addressTF, attribute: .centerY, relatedBy: .equal, toItem: addressLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: addressTF, attribute: .height, relatedBy: .equal, toItem: universityNameTF, attribute: .height, multiplier: 1.0, constant: 0.0))
        
        contentView.addSubview(addressLatLbl)
        
        documentView.addConstraint(NSLayoutConstraint(item: addressLatLbl, attribute: .leading, relatedBy: .equal, toItem: addressLabel, attribute: .leading, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: addressLatLbl, attribute: .top, relatedBy: .equal, toItem: addressLabel, attribute: .bottom, multiplier: 1.0, constant: 24.0))
        
        contentView.addSubview(addressLatTF)
        
        documentView.addConstraint(NSLayoutConstraint(item: addressLatTF, attribute: .leading, relatedBy: .equal, toItem: addressTF, attribute: .leading, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: addressLatTF, attribute: .centerY, relatedBy: .equal, toItem: addressLatLbl, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: addressLatTF, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 120.0))
        documentView.addConstraint(NSLayoutConstraint(item: addressLatTF, attribute: .height, relatedBy: .equal, toItem: addressTF, attribute: .height, multiplier: 1.0, constant: 0.0))
        
        contentView.addSubview(addressLngLbl)
        
        documentView.addConstraint(NSLayoutConstraint(item: addressLngLbl, attribute: .leading, relatedBy: .equal, toItem: addressLatLbl, attribute: .leading, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: addressLngLbl, attribute: .top, relatedBy: .equal, toItem: addressLatLbl, attribute: .bottom, multiplier: 1.0, constant: 24.0))
        
        contentView.addSubview(addressLngTF)
        
        documentView.addConstraint(NSLayoutConstraint(item: addressLngTF, attribute: .centerX, relatedBy: .equal, toItem: addressLatTF, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: addressLngTF, attribute: .width, relatedBy: .equal, toItem: addressLatTF, attribute: .width, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: addressLngTF, attribute: .centerY, relatedBy: .equal, toItem: addressLngLbl, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: addressLngTF, attribute: .height, relatedBy: .equal, toItem: addressLatTF, attribute: .height, multiplier: 1.0, constant: 0.0))
        
        let buttonsStackView = NSStackView(views: [okButton, cancelButton])
        buttonsStackView.orientation = .horizontal
        buttonsStackView.alignment = .centerY
        buttonsStackView.distribution = .fillProportionally
        contentView.addSubview(buttonsStackView)
        
        documentView.addConstraint(NSLayoutConstraint(item: buttonsStackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 220.0))
        documentView.addConstraint(NSLayoutConstraint(item: buttonsStackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0))
        documentView.addConstraint(NSLayoutConstraint(item: buttonsStackView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: buttonsStackView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 24.0))
        documentView.addConstraint(NSLayoutConstraint(item: buttonsStackView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: addressLngTF, attribute: .bottom, multiplier: 1.0, constant: 24.0))
    }
    
    override func validateInput() -> Bool {
        return universityNameTF.stringValue.count > 0 && addressTF.stringValue.count > 0 && addressLatTF.stringValue.count > 0 && addressLngTF.stringValue.count > 0
    }
    
    //MARK: Custom Actions
    @objc private func okTapped() {
        guard validateInput() else {
            self.view.window?.close()
            return
        }
        
        var university: University?
        
        switch action {
        case .create:
            university = DataModel.shared.emptyObject(name: University.entityName) as? University
        case .edit(let object):
            university = object as? University
        case .preview(_): break
        }
        
        if let fetchedUnivesity = university {
            fetchedUnivesity.name = universityNameTF.stringValue
            
            let universityAddress = DataModel.shared.emptyObject(name: Address.entityName) as! Address
            universityAddress.formattedAddress = addressTF.stringValue
            universityAddress.lat = addressLatTF.doubleValue
            universityAddress.lng = addressLngTF.doubleValue
            universityAddress.building = university
            
            fetchedUnivesity.address = universityAddress
            if let major = majorObject {
                fetchedUnivesity.majorID = major.uniqueID
            }
            
            switch action {
            case .create:
                DataModel.shared.insertObject(withModel: fetchedUnivesity)
            case .edit(_), .preview(_): break
            }
        }
        
        self.view.window?.close()
    }
    
    @objc private func cancelTapped() {
        self.view.window?.close()
    }
}
