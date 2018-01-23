//
//  FormPresenter.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/19/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//

import Cocoa

class FormPresenter {
    typealias TypeSelectionFormCompletion = ((_ selectedType: Object.Type) -> Void)
    
    enum ObjectDetailsFormAction {
        case edit
        case preview
    }
    
    //MARK: Public Methods
    class func presentNewObjectTypeSelectionForm(forMajorObject major: Object?, completion: @escaping TypeSelectionFormCompletion) {
        guard let typeSelectionWC = NSStoryboard(name: NSStoryboard.Name(rawValue: "Forms"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "TypeSelectionWC")) as? NSWindowController, let typeSelectionWindow = typeSelectionWC.window, let typeSelectionVC = typeSelectionWindow.contentViewController as? TypeSelectionVC else {
            return
        }
        
        typeSelectionVC.majorObject = major
        typeSelectionVC.completion = { (selectedType) in
            completion(selectedType)
        }
        
        FormPresenter.presentModalWindow(typeSelectionWindow)
    }
    
    class func presentObjectInfoForm(forObject object: Object, withAction action: ObjectDetailsFormAction) {
        let objectType = type(of: object)
        let form = FormFactory.createForm(forObjectType: objectType)
        if let window = form.window,
            let viewController = window.contentViewController as? FormVC {
            viewController.object = object
            FormPresenter.presentModalWindow(window)
        }
    }
    
    class func presentCreateObjectForm(withType objectType: Object.Type) {
        let form = FormFactory.createForm(forObjectType: objectType)
        if let window = form.window {
            FormPresenter.presentModalWindow(window)
        }
    }
    
    //MARK: Private Methods
    private class func presentModalWindow(_ window: NSWindow) {
        NSApplication.shared.runModal(for: window)
        window.close()
    }
}
