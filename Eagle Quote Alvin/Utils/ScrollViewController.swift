//
//  ScrollViewController.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ScrollViewController: UIViewController {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var contentView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if scrollView.superview == nil {
      view.addSubview(scrollView)
      scrollView.snp.makeConstraints { (make) in
        make.edges.equalToSuperview()
      }
    }
    if contentView.superview == nil {
      //contentView.backgroundColor = UIColor.orange
      scrollView.addSubview(contentView)
      contentView.snp.makeConstraints { (make) in
        make.edges.equalTo(scrollView).offset(0)
        make.width.equalTo(view)
      }
    }
    
    scrollView.alwaysBounceVertical = true
    scrollView.keyboardDismissMode = .interactive
    addKeyboardVisibilityEventObservers()
  }
  
  func addKeyboardVisibilityEventObservers() {
    NotificationCenter.default
      .addObserver(self,
                   selector: #selector(keyboardWillShowOrHideHandler(_:)),
                   name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default
      .addObserver(self,
                   selector: #selector(keyboardWillShowOrHideHandler(_:)),
                   name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  @objc
  func keyboardWillShowOrHideHandler(_ notification: NSNotification) {
    
    // Pull a bunch of info out of the notification
    if let scrollView = scrollView,
      let userInfo = notification.userInfo,
      let endValue = userInfo[UIKeyboardFrameEndUserInfoKey],
      let durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] {
      
      // Transform the keyboard's frame into our view's coordinate system
      let endRect = view.convert((endValue as AnyObject).cgRectValue, from: view.window)
      
      // Find out how much the keyboard overlaps the scroll view
      // We can do this because our scroll view's frame is already in our view's coordinate system
      let keyboardOverlap = scrollView.frame.maxY - endRect.origin.y
      
      // Set the scroll view's content inset to avoid the keyboard
      // Don't forget the scroll indicator too!
      let offset = keyboardOverlap >= 0 ? keyboardOverlap : 0
      scrollView.contentInset.bottom = offset
      scrollView.scrollIndicatorInsets.bottom = offset
      
      let duration = (durationValue as AnyObject).doubleValue
      UIView.animate(withDuration: duration!, delay: 0, options: .beginFromCurrentState, animations: {
        self.view.layoutIfNeeded()
      }, completion: nil)
    }
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
}
