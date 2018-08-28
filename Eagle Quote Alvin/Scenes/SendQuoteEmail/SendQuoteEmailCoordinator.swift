//
//  SendQuoteEmailCoordinator.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import RxSwift

class SendQuoteEmailCoordinator: BaseCoordinator<Void> {

  private weak var window: UIWindow?
  private let quote: Quote

  init(window: UIWindow?, quote: Quote) {
    self.window = window
    self.quote = quote
  }

  override func start() -> Observable<Void> {

    guard let user = UIApplication.shared.appDelegate.sessionService.user else {
      preconditionFailure("There is no logged in user")
    }

    let vm = SendQuoteEmailViewModel(user: user, quote: quote)
    let vc = SendQuoteEmailController(nibName: "SendQuoteEmailController", bundle: nil)
    vc.viewModel = vm

    vm.didSuccessfullySendEmail
      .subscribe(onNext: { [weak self] _ in
        self?.handleSuccessfulEmailSent()
      })
      .disposed(by: disposeBag)

    Observable.merge(
      vm.didInvalidateForm,
      vm.didReceiveSendQuoteEmailError
    )
      .subscribe(onNext: { [weak self] error in
        self?.show(error)
      })
      .disposed(by: disposeBag)

    let nc = window?.rootViewController as! UINavigationController
    nc.pushViewController(vc, animated: true)


    return Observable.never()
  }

}

extension SendQuoteEmailCoordinator {

  fileprivate func handleSuccessfulEmailSent() {
    let nc = window?.rootViewController as? UINavigationController
    nc?.popViewController(animated: true)
    showSendEmailSuccessMessage()
  }
  
  fileprivate func showSendEmailSuccessMessage() {
    let ac = UIAlertController.alert(title: "Email successfully sent!", message: "Quote email has been sent.")
    self.window!.rootViewController!.present(ac, animated: true)
  }

  fileprivate func show(_ error: LoginErrorInfo) {
    let ac = UIAlertController.alert(title: error.title, message: error.message)
    window!.rootViewController!.present(ac, animated: true)
  }

  fileprivate func showAlert(title: String, message: String) {
    let ac = UIAlertController.alert(title: title, message: message)
    window!.rootViewController!.present(ac, animated: true)
  }
}
