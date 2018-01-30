//
//  ViewController.swift
//  DatabaseExplorer
//
//  Created by admin on 10/7/17.
//  Copyright © 2017 rstakhiv. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet private weak var contextMenu: NSMenu!
    @IBOutlet private weak var outlineView: NSOutlineView!
    
    private var selectedObject: Object?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupContextMenu()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    //MARK: Private Methods
    private func setupContextMenu() {
        self.outlineView.menu = contextMenu
    }
    
    //MARK: Menu Handling
    @objc private func handleAddMenuButton() {
        FormPresenter.presentNewObjectTypeSelectionForm(forMajorObject: selectedObject, completion: { (selectedType) in
            FormPresenter.presentCreateObjectForm(withType: selectedType)
        })
    }
    
    @objc private func handleShowInfoMenuButton() {
        guard let selectedObject = selectedObject else {
            return
        }
        
        FormPresenter.presentObjectInfoForm(forObject: selectedObject, withAction: .preview(selectedObject))
    }
    
    @objc private func handleEditMenuButton() {
        guard let selectedObject = selectedObject else {
            return
        }
        
        FormPresenter.presentObjectInfoForm(forObject: selectedObject, withAction: .edit(selectedObject))
    }
}

extension ViewController: NSMenuDelegate {
    func menuNeedsUpdate(_ menu: NSMenu) {
        menu.removeAllItems()
        
        menu.addItem(NSMenuItem(title: "Add", action: #selector(handleAddMenuButton), keyEquivalent: ""))
        let row = self.outlineView.clickedRow
        
        guard row != -1 else {
            selectedObject = nil
            return
        }
        
        menu.addItem(NSMenuItem(title: "Edit", action: #selector(handleEditMenuButton), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Preview", action: #selector(handleShowInfoMenuButton), keyEquivalent: ""))
        selectedObject = outlineView.item(atRow: row) as? Object
    }
}

extension ViewController: NSOutlineViewDataSource {
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil {
            return DataModel.shared.fetchRootObjects().count
        } else {
            guard let object = item as? Object else {
                return 0
            }
            
            return DataModel.shared.fetchChildrenForObject(object).count
        }
    }

    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if item == nil {
            return DataModel.shared.fetchRootObjects()[index]
        } else {
            let object = item as! Object
            let childrenOfItem = DataModel.shared.fetchChildrenForObject(object)
            return childrenOfItem[index]
        }
    }

    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        guard let object = item as? Object else {
            return false
        }
        
        let children = DataModel.shared.fetchChildrenForObject(object)
        return children.count > 0
    }
}

extension ViewController: NSOutlineViewDelegate {
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        var view: NSTableCellView?
        //1
        if let object = item as? Object {
            
            view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ItemCell"), owner: self) as? NSTableCellView
            if let textField = view?.textField,
                let objectName = object.name {
                textField.stringValue = objectName
                textField.sizeToFit()
            }
        }
        
        return view
    }
}


