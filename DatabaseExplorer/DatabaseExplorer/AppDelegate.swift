//
//  AppDelegate.swift
//  DatabaseExplorer
//
//  Created by admin on 10/7/17.
//  Copyright © 2017 rstakhiv. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        UserDefaults.standard.setValue(DataModel.shared.lastCreatedObjectID, forKey: Constants.lastCreatedObjectIDKey)
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        DataModel.shared.saveContext()
        return .terminateNow
    }

}

