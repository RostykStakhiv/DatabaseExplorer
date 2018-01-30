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
    
    //MARK: Public Methods
    class func presentNewObjectTypeSelectionForm(forMajorObject major: Object?, completion: @escaping TypeSelectionFormCompletion) {
        guard let typeSelectionWC = NSStoryboard(name: NSStoryboard.Name(rawValue: "Forms"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "TypeSelectionWC")) as? TypeSelectionWC, let typeSelectionWindow = typeSelectionWC.window, let typeSelectionVC = typeSelectionWindow.contentViewController as? TypeSelectionVC else {
            return
        }
        
        typeSelectionVC.majorObject = major
        typeSelectionVC.completion = { (selectedType) in
            completion(selectedType)
        }
        
        FormPresenter.presentWindowController(typeSelectionWC)
    }
    
    class func presentObjectInfoForm(forObject object: Object, withAction action: FormVC.ObjectDetailsFormAction) {
        guard let form = FormFactory.createForm(object: object), let formContentVC = form.window?.contentViewController as? FormVC else {
            return
        }
        
        formContentVC.action = action
        FormPresenter.presentWindowController(form)
    }
    
    class func presentCreateObjectForm(withType objectType: Object.Type) {
        guard let form = FormFactory.createForm(forObjectType: objectType) else {
            return
        }
        
        FormPresenter.presentWindowController(form)
    }
    
    //MARK: Private Methods
    private class func presentWindowController(_ windowController: NSWindowController) {
        windowController.showWindow(nil)
    }
}
