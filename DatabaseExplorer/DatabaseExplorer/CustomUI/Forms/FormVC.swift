//
//  FormVC.swift
//  DatabaseExplorer
//
//  Created by KindGeek on 1/23/18.
//  Copyright © 2018 rstakhiv. All rights reserved.
//

import Cocoa

class FormVC: NSViewController {
    
    enum ObjectDetailsFormAction {
        case create
        case edit(Object)
        case preview(Object)
        
        static public func == (lhs: ObjectDetailsFormAction, rhs: ObjectDetailsFormAction) -> Bool {
            switch (lhs, rhs) {
            case let (.edit(a), edit(b)):
                return a == b
             case let (.preview(a), preview(b)):
                return a == b
            case  (.create, .create):
                return true
            default: return false
            }
        }
    }
    
    var majorObject: Object?
    var action: ObjectDetailsFormAction = .create {
        didSet {
            switch action {
            case .edit(let object), .preview(let object):
                self.object = object
            case .create: break
            }
        }
    }
    
    var completion: ((_ object: Object) -> Void)?
    
    internal var object: Object?
    
    internal var scrollView: NSScrollView = NSScrollView()
    internal var contentView: NSView = NSView()
    internal var lastUIElement: AnyObject?
    
    internal var okButton: NSButton = {
        let ok = NSButton(title: "OK", target: self, action: #selector(okTapped))
        ok.keyEquivalent = "\r"
        return ok
    }()
    
    internal var cancelButton: NSButton = {
        let cancel = NSButton(title: "Cancel", target: self, action: #selector(cancelTapped))
        return cancel
    }()
    
    //MARK: Lifecycle
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 50.0, y: 50.0, width: 600.0, height: 500.0))
    }
    
    //MARK: Public Methods
    func setupForm() {
        setupScrollView()
    }
    
    //MARK: Internal Methods
    internal func validateInput() -> Bool {
        assertionFailure("Override in subclass")
        return false
    }
    
    internal func addButtons(_ buttons: [NSButton]) {
        guard let documentView = scrollView.documentView else {
            return
        }
        
        let buttonsStackView = NSStackView(views: buttons)
        buttonsStackView.orientation = .horizontal
        buttonsStackView.alignment = .centerY
        buttonsStackView.distribution = .fillProportionally
        contentView.addSubview(buttonsStackView)
        
        let stackViewWidth: CGFloat = 110.0 * CGFloat(buttons.count)
        
        documentView.addConstraint(NSLayoutConstraint(item: buttonsStackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: stackViewWidth))
        documentView.addConstraint(NSLayoutConstraint(item: buttonsStackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0))
        documentView.addConstraint(NSLayoutConstraint(item: buttonsStackView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        documentView.addConstraint(NSLayoutConstraint(item: buttonsStackView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 24.0))
        documentView.addConstraint(NSLayoutConstraint(item: buttonsStackView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: lastUIElement, attribute: .bottom, multiplier: 1.0, constant: 24.0))
    }
    
    //MARK: Private Methods
    private func setupScrollView() {

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
    
    //MARK: Custom Actions
    @objc internal func okTapped() {
        self.view.window?.close()
    }
    
    @objc internal func cancelTapped() {
        self.view.window?.close()
    }
}
