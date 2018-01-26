//
//  FormVC.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/23/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//

import Cocoa

class FormVC: NSViewController {
    
    var object: Object?
    internal var scrollView: NSScrollView = NSScrollView()
    internal var contentView: NSView = NSView()
    
    //MARK: Lifecycle
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 50.0, y: 50.0, width: 600.0, height: 500.0))
        setupForm()
    }
    
    //MARK: Public Methods
    func setupForm() {
        setupScrollView()
    }
    
    //MARK: Internal Methods
    internal func validateInput() -> (Bool, Object?) {
        assertionFailure("Override in subclass")
        return (false, nil)
    }
    
    //MARK: Private Methods
    private func setupScrollView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        // Initial scrollview
        scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.borderType = .noBorder
        scrollView.backgroundColor = NSColor.gray
        scrollView.hasVerticalScroller = true
        
        view.addSubview(scrollView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: nil, views: ["scrollView": scrollView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: [], metrics: nil, views: ["scrollView": scrollView]))
        
        // Initial clip view
        let clipView = NSClipView()
        clipView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentView = clipView
        scrollView.addConstraint(NSLayoutConstraint(item: clipView, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1.0, constant: 0))
        scrollView.addConstraint(NSLayoutConstraint(item: clipView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 0))
        scrollView.addConstraint(NSLayoutConstraint(item: clipView, attribute: .right, relatedBy: .equal, toItem: scrollView, attribute: .right, multiplier: 1.0, constant: 0))
        scrollView.addConstraint(NSLayoutConstraint(item: clipView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: 0))
        
        // Initial document view
        let documentView = NSView()
        documentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.documentView = documentView
        clipView.addConstraint(NSLayoutConstraint(item: clipView, attribute: .left, relatedBy: .equal, toItem: documentView, attribute: .left, multiplier: 1.0, constant: 0))
        clipView.addConstraint(NSLayoutConstraint(item: clipView, attribute: .top, relatedBy: .equal, toItem: documentView, attribute: .top, multiplier: 1.0, constant: 0))
        clipView.addConstraint(NSLayoutConstraint(item: clipView, attribute: .right, relatedBy: .equal, toItem: documentView, attribute: .right, multiplier: 1.0, constant: 0))
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        documentView.addSubview(contentView)
        documentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: documentView, attribute: .top, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: documentView, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: documentView, attribute: .leading, multiplier: 1.0, constant: 0.0))
        
        let bottomConstraint = NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: documentView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        documentView.addConstraint(bottomConstraint)
        
        let heightContraint = NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0)
        heightContraint.priority = NSLayoutConstraint.Priority(rawValue: 1000)
        contentView.addConstraint(heightContraint)
    }
    
}
