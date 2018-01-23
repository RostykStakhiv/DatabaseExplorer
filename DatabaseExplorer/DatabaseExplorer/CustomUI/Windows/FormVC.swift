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
    
    internal var contentView: NSView = NSView()
    internal var scrollView: NSScrollView = NSScrollView()

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupForm()
    }
    
    //MARK: Public Methods
    func setupForm() {
        setupScrollView()
    }
    
    //MARK: Private Methods
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.borderType = .noBorder
        scrollView.backgroundColor = .gray
        scrollView.hasVerticalScroller = true
        
        let clipView = NSClipView()
        clipView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentView = clipView
        scrollView.addConstraint(NSLayoutConstraint(item: clipView, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1.0, constant: 0))
        scrollView.addConstraint(NSLayoutConstraint(item: clipView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 0))
        scrollView.addConstraint(NSLayoutConstraint(item: clipView, attribute: .right, relatedBy: .equal, toItem: scrollView, attribute: .right, multiplier: 1.0, constant: 0))
        scrollView.addConstraint(NSLayoutConstraint(item: clipView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: 0))
        
        NSLayoutConstraint(item: scrollView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: scrollView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: scrollView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: scrollView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let documentView = NSView()
        documentView.addSubview(contentView)
            
        NSLayoutConstraint(item: contentView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: documentView,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: contentView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: documentView,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: contentView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: documentView,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: contentView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: documentView,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        
        scrollView.documentView = documentView
    }
    
}
