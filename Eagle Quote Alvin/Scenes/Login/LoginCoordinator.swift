//
//  LoginCoordinator.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import RxSwift

class LoginCoordinator: BaseCoordinator<Void> {

  private weak var window: UIWindow?

  init(window: UIWindow?) {
    self.window = window
  }

  override func start() -> Observable<Void> {

    let vm = LoginViewModel()
    let vc = LoginController(nibName: "LoginController", bundle: nil)
    vc.viewModel = vm

    vm.didLoginSuccessfully
      .subscribe(onNext: { [weak self] loginResult in
        self?.handleSuccessfulLogin(with: loginResult)
      })
      .disposed(by: disposeBag)

    Observable.merge(
      vm.didInvalidateLoginCredentials,
      vm.didReceiveLoginError
    )
      .subscribe(onNext: { [weak self] error in
        self?.show(error)
      })
      .disposed(by: disposeBag)

    let nc = UINavigationController(rootViewController: vc)
    nc.isNavigationBarHidden = true

    window?.rootViewController = nc

    return Observable.never()
  }

}

extension LoginCoordinator {

  fileprivate func handleSuccessfulLogin(with loginResult: LoginResult) {
    UIApplication.shared.appDelegate.sessionService.login(
      user: loginResult.user,
      with: loginResult.authorization
    )
    self.showDashboard()
  }

  fileprivate func showDashboard() {
    let dashboardCoordinator = DashboardCoordinator(window: window)
    coordinate(to: dashboardCoordinator)
      .subscribe()
      .disposed(by: disposeBag)
  }
  
  fileprivate func show(_ error: LoginErrorInfo) {
    let ac = UIAlertController.alert(title: error.title, message: error.message)
    self.window!.rootViewController!.present(ac, animated: true)
  }

}
