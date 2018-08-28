//
//  SendQuoteEmailController.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa
import KSTokenView
import UITextView_Placeholder
import SVProgressHUD

class SendQuoteEmailController: ScrollViewController {

  @IBOutlet weak var toTokenView: KSTokenView!
  @IBOutlet weak var ccTokenView: KSTokenView!
  @IBOutlet weak var tokenViewHeightALC: NSLayoutConstraint!

  @IBOutlet weak var subjectTextField: UITextField!
  @IBOutlet weak var bodyTextView: UITextView!

  private var airplaneBarButton: UIBarButtonItem!
  var viewModel: SendQuoteEmailViewModelType!

  private let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    bind()
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
    let airplaneBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-plane"), style: .plain, target: self, action: nil)
    navigationItem.rightBarButtonItem = airplaneBarButton
    self.airplaneBarButton = airplaneBarButton
  }

  private func bind() {

    viewModel.output.defaultSubject
      .observeOn(MainScheduler.instance)
      .bind(to: subjectTextField.rx.text)
      .disposed(by: disposeBag)

    viewModel.output.defaultBody
      .observeOn(MainScheduler.instance)
      .bind(to: bodyTextView.rx.text)
      .disposed(by: disposeBag)

    viewModel.output.defaultCcEmails
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] ccEmails in
        ccEmails.forEach {
          self?.ccTokenView.addTokenWithTitle($0)
        }
      })
      .disposed(by: disposeBag)

    subjectTextField.rx.text
      .bind(to: viewModel.input.subject)
      .disposed(by: disposeBag)
    
    bodyTextView.rx.text
      .bind(to: viewModel.input.body)
      .disposed(by: disposeBag)

    let airplaneButtonTap = airplaneBarButton.rx.tap

    airplaneButtonTap
      .map { [weak self] _ in
        guard let s = self else { return [] }
        return s.toTokenView.tokens().map { tokens in
          return tokens.map { $0.title }
        } ?? [String]()
      }
      .bind(to: viewModel.input.toEmails)
      .disposed(by: disposeBag)

    airplaneButtonTap
      .map { [weak self] _ in
        guard let s = self else { return [] }
        return s.ccTokenView.tokens().map { tokens in
          return tokens.map { $0.title }
        } ?? [String]()
      }
      .bind(to: viewModel.input.ccEmails)
      .disposed(by: disposeBag)

    airplaneButtonTap
      .delay(0.1, scheduler: MainScheduler.instance)
      .do(onNext: { [weak self] _ in
        self?.view.endEditing(true)
      })
      .bind(to: viewModel.input.sendEmailTapped)
      .disposed(by: disposeBag)

    viewModel.output.sendingEmail
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { _ in
        SVProgressHUD.show()
      })
      .disposed(by: disposeBag)

    Observable.merge(
      viewModel.output.didReceiveSendQuoteEmailError.map { _ in return Void() },
      viewModel.output.didSuccessfullySendEmail
    )
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { _ in
        SVProgressHUD.dismiss()
      })
      .disposed(by: disposeBag)

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
