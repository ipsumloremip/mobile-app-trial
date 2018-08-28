//
//  SendQuoteEmailController.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

import KSTokenView
import UITextView_Placeholder

class SendQuoteEmailController: ScrollViewController {
  
  @IBOutlet weak var toTokenView: KSTokenView!
  @IBOutlet weak var ccTokenView: KSTokenView!
  @IBOutlet weak var tokenViewHeightALC: NSLayoutConstraint!
  
  @IBOutlet weak var subjectTextField: UITextField!
  @IBOutlet weak var bodyTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
  private func setup() {
    setupNavbar()
    
    setupTokenViews()
    setupTextView()
  }
  
  private func setupTokenViews() {
    commonSetup(toTokenView)
    commonSetup(ccTokenView)
    
    toTokenView.promptText = "To:     "
    ccTokenView.promptText = "Cc:     "
  }
  
  private func commonSetup(_ tokenView: KSTokenView) {
    tokenView.delegate = self
    tokenView.searchResultHeight = 0
    tokenView.tokenizingCharacters = []
    tokenView.placeholder = "Type email"
    tokenView.maximumHeight = tokenViewHeightALC.constant
    tokenView.maxTokenLimit = 10
    tokenView.font = UIFont.systemFont(ofSize: 15)
    tokenView.minWidthForInput = 20
    tokenView.paddingX = 8
    tokenView.marginX = 0
  }
  
  private func setupTextView() {
    bodyTextView.placeholder = "Compose Message"
  }
  
  private func setupNavbar() {
    title = "Send by Email"
    // TODO action
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-plane"), style: .plain, target: self, action: nil)
  }
  
}

extension SendQuoteEmailController: KSTokenViewDelegate {
  
  func tokenView(_ tokenView: KSTokenView, performSearchWithString string: String, completion: ((Array<AnyObject>) -> Void)?) {
    // noop
  }
  
  func tokenView(_ tokenView: KSTokenView, displayTitleForObject object: AnyObject) -> String {
    return ""
  }
  
  func tokenView(_ tokenView: KSTokenView, shouldAddToken token: KSToken) -> Bool {
    return token.title.isValidEmail
  }
  
  func tokenView(_ tokenView: KSTokenView, willAddToken token: KSToken) {
    token.tokenBackgroundColor = UIColor.EagleQuote.lightestGray
    token.tokenTextColor = .black
  }
  
  
}
