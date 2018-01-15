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

    private lazy var rootObjects: [Object] = {
        return DataModel.shared.fetchRootObjects()
    }()
    
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
        self.view.menu = contextMenu
    }
    
    //MARK: Menu Handling
    @IBAction func handleAddMenuButton(_ item: NSMenuItem) {
        let person = DataModel.shared.emptyObject(name: "Person", context: nil) as! Person
        person.name = "Person"
        person.firstName = "Ivan"
        person.lastName = "Ivanov"
        person.sex = true
        
        let insertSuccess = DataModel.shared.insertObject(withModel: person)
        print(insertSuccess)
    }
    
    @IBAction func handleShowInfoMenuButton(_ item: NSMenuItem) {
        
    }
    
    @IBAction func handleEditMenuButton(_ item: NSMenuItem) {
        
    }
}

extension ViewController: NSMenuDelegate {
    
}

extension ViewController: NSOutlineViewDataSource {
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil {
            return rootObjects.count
        } else {
            guard let object = item as? Object else {
                return 0
            }
            
            return DataModel.shared.fetchChildrenForObjectWithID(object.uniqueID).count
        }
    }

    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if item == nil {
            return rootObjects[index]
        } else {
            let object = item as! Object
            let childrenOfItem = DataModel.shared.fetchChildrenForObjectWithID(object.uniqueID)
            return childrenOfItem[index]
        }
    }

    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        guard let object = item as? Object else {
            return false
        }
        
        let children = DataModel.shared.fetchChildrenForObjectWithID(object.uniqueID)
        return children.count > 0
    }
}

//extension ViewController: NSOutlineViewDelegate {
//    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
//        var view: NSTableCellView?
//        //1
//        if let feed = item as? Feed {
//            if tableColumn?.identifier == "DateColumn" {
//                view = outlineView.make(withIdentifier: "DateCell", owner: self) as? NSTableCellView
//                if let textField = view?.textField {
//                    textField.stringValue = ""
//                    textField.sizeToFit()
//                }
//            } else {
//                view = outlineView.make(withIdentifier: "FeedCell", owner: self) as? NSTableCellView
//                if let textField = view?.textField {
//                    textField.stringValue = feed.name
//                    textField.sizeToFit()
//                }
//            }
//        } else if let feedItem = item as? FeedItem {
//            //1
//            if tableColumn?.identifier == "DateColumn" {
//                //2
//                view = outlineView.make(withIdentifier: "DateCell", owner: self) as? NSTableCellView
//
//                if let textField = view?.textField {
//                    //3
//                    textField.stringValue = dateFormatter.string(from: feedItem.publishingDate)
//                    textField.sizeToFit()
//                }
//            } else {
//                //4
//                view = outlineView.make(withIdentifier: "FeedItemCell", owner: self) as? NSTableCellView
//                if let textField = view?.textField {
//                    //5
//                    textField.stringValue = feedItem.title
//                    textField.sizeToFit()
//                }
//            }
//        }
//        //More code here
//        return view
//    }
//
//    func outlineViewSelectionDidChange(_ notification: Notification) {
//        //1
//        guard let outlineView = notification.object as? NSOutlineView else {
//            return
//        }
//
//        //2
//        let selectedIndex = outlineView.selectedRow
//
//        if let feedItem = outlineView.item(atRow: selectedIndex) as? FeedItem {
//            //3
//            let url = URL(string: feedItem.url)
//            //4
//            if let url = url {
//                //5
//                self.webView.mainFrame.load(URLRequest(url: url))
//            }
//        }
//    }
//}


