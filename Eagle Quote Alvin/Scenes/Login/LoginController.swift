//
//  LoginController.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

class LoginController: UIViewController {

  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var iconImageViewFullWidthALC: NSLayoutConstraint!
  @IBOutlet weak var iconImageViewSupressedWidthALC: NSLayoutConstraint!
  
  @IBOutlet weak var signupStackViewZeroHeightALC: NSLayoutConstraint!
  @IBOutlet weak var signupButtonsStackView: UIStackView!
  @IBOutlet weak var signupButtonHeightALC: NSLayoutConstraint!
  @IBOutlet weak var signupStackViewBottomSpaceViewHeightALC: NSLayoutConstraint!
  
  @IBOutlet weak var loginStackViewZeroHeightALC: NSLayoutConstraint!
  @IBOutlet weak var loginStackView: UIStackView!

  
  @IBAction func signInButtonTapped(_ sender: Any) {

    self.iconImageViewFullWidthALC.isActive = false
    self.iconImageViewSupressedWidthALC.isActive = true

    UIView.animate(withDuration: 0.35, animations: {
      self.signupButtonsStackView.alpha = 0
      self.view.layoutIfNeeded()
    }) { _ in
      
      self.signupStackViewBottomSpaceViewHeightALC.constant = 0
      self.signupButtonHeightALC.constant = 0
      self.signupStackViewZeroHeightALC.isActive = true
      
      self.loginStackView.isHidden = false
      self.loginStackViewZeroHeightALC.isActive = false
      
      UIView.animate(withDuration: 0.35, animations: {
        self.view.layoutIfNeeded()
      })
    }
    
  }
}
