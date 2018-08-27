//
//  LoginController.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa

class LoginController: UIViewController {

  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var iconImageViewFullWidthALC: NSLayoutConstraint!
  @IBOutlet weak var iconImageViewSupressedWidthALC: NSLayoutConstraint!

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  @IBOutlet weak var signupStackViewZeroHeightALC: NSLayoutConstraint!
  @IBOutlet weak var signupButtonsStackView: UIStackView!
  @IBOutlet weak var signupButtonHeightALC: NSLayoutConstraint!
  @IBOutlet weak var signupStackViewBottomSpaceViewHeightALC: NSLayoutConstraint!

  @IBOutlet var loginStackViewZeroHeightALC: NSLayoutConstraint!
  @IBOutlet weak var loginStackView: UIStackView!

  @IBOutlet weak var signInButton: RoundedCornersButton!
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!

  var viewModel: LoginViewModelType!

  private let animationDuration = 0.25
  private let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    bind()
  }
  
  private func setup() {
    emailTextField.delegate = self
    passwordTextField.delegate = self
  }
  
  private func bind() {

    emailTextField.rx.text
      .bind(to: viewModel.input.email)
      .disposed(by: disposeBag)
    
    passwordTextField.rx.text
      .bind(to: viewModel.input.password)
      .disposed(by: disposeBag)

    signInButton.rx.tap
      .bind(to: viewModel.input.login)
      .disposed(by: disposeBag)

    viewModel.output.loggingIn
      .subscribe(onNext: { [weak self] _ in
        self?.showLoadingUI()
      })
      .disposed(by: disposeBag)
    
    viewModel.output.didReceiveLoginError
      .subscribe(onNext: { [weak self] _ in
        self?.revertLoadingUI()
      })
      .disposed(by: disposeBag)

  }
  
  @IBAction func showSignInButtonTapped(_ sender: Any) {
    showSignInView()
  }

}

extension LoginController {

  fileprivate func showLoadingUI() {
    
    self.loginStackView.isHidden = true
    NSLayoutConstraint.activate([loginStackViewZeroHeightALC])
    
    UIView.animate(withDuration: self.animationDuration, animations: {
      self.view.layoutIfNeeded()
    }) { _ in
      
      NSLayoutConstraint.deactivate([self.iconImageViewSupressedWidthALC])
      NSLayoutConstraint.activate([self.iconImageViewFullWidthALC])
      
      UIView.animate(withDuration: self.animationDuration, animations: {
        self.view.layoutIfNeeded()
      }) { _ in
        self.activityIndicator.startAnimating()
      }
    }
    
  }
  
  fileprivate func revertLoadingUI() {
    
    NSLayoutConstraint.deactivate([self.iconImageViewFullWidthALC])
    NSLayoutConstraint.activate([self.iconImageViewSupressedWidthALC])
    
    self.activityIndicator.stopAnimating()
    UIView.animate(withDuration: self.animationDuration, animations: {
      self.view.layoutIfNeeded()
    }) { _ in
      
      self.loginStackView.isHidden = false
      NSLayoutConstraint.deactivate([self.loginStackViewZeroHeightALC])
      
      UIView.animate(withDuration: self.animationDuration, animations: {
        self.view.layoutIfNeeded()
      })
    }
    
  }
  
  fileprivate func showSignInView() {
    self.iconImageViewFullWidthALC.isActive = false
    self.iconImageViewSupressedWidthALC.isActive = true
    
    UIView.animate(withDuration: self.animationDuration, animations: {
      self.signupButtonsStackView.alpha = 0
      self.view.layoutIfNeeded()
    }) { _ in
      
      self.signupStackViewBottomSpaceViewHeightALC.constant = 0
      self.signupButtonHeightALC.constant = 0
      self.signupStackViewZeroHeightALC.isActive = true
      
      self.loginStackView.isHidden = false
      self.loginStackViewZeroHeightALC.isActive = false
      
      UIView.animate(withDuration: self.animationDuration, animations: {
        self.view.layoutIfNeeded()
      })
    }
  }

}

extension LoginController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
  
}
