//
//  FormPresenter.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/19/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//

import Cocoa

class FormPresenter {
    
    class func presentNewObjectTypeSelectionForm(forMajorObject major: Object?) {
        guard let typeSelectionWC = NSStoryboard(name: NSStoryboard.Name(rawValue: "Forms"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "TypeSelectionWC")) as? NSWindowController, let typeSelectionWindow = typeSelectionWC.window, let typeSelectionVC = typeSelectionWindow.contentViewController as? TypeSelectionVC else {
            return
        }
        
        typeSelectionVC.majorObject = major
        typeSelectionVC.completion = { (selectedType) in
            if selectedType == University.self {
                
            }
        }
        NSApplication.shared.runModal(for: typeSelectionWindow)
        typeSelectionWindow.close()
    }
}
