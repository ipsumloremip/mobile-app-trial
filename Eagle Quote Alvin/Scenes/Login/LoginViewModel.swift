//
//  LoginViewModel.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import RxSwift
import Moya

typealias LoginErrorInfo = (title: String, message: String)

protocol LoginViewModelInput {
  var email: AnyObserver<String?> { get }
  var password: AnyObserver<String?> { get }
  var login: AnyObserver<Void> { get }
}

protocol LoginViewModelOutput {
  var didLoginSuccessfully: Observable<LoginResult> { get }
  var didReceiveLoginError: Observable<LoginErrorInfo> { get }
  var didInvalidateLoginCredentials: Observable<LoginErrorInfo> { get }
  var loggingIn: Observable<Void> { get }
}

protocol LoginViewModelType {
  var input: LoginViewModelInput { get }
  var output: LoginViewModelOutput { get }
}

class LoginViewModel: LoginViewModelType, LoginViewModelInput, LoginViewModelOutput {

  typealias Credentials = (email: String?, password: String?)

  var input: LoginViewModelInput { return self }
  var output: LoginViewModelOutput { return self }

  // MARK: Input
  var email: AnyObserver<String?>
  var password: AnyObserver<String?>
  var login: AnyObserver<Void>

  // MARK: Output
  var didLoginSuccessfully: Observable<LoginResult>
  var didReceiveLoginError: Observable<LoginErrorInfo>
  var didInvalidateLoginCredentials: Observable<LoginErrorInfo>
  var loggingIn: Observable<Void>

  init(service: APIServiceType = APIService()) {

    let _login = PublishSubject<Void>()
    self.login = _login.asObserver()

    let _email = BehaviorSubject<String?>(value: nil)
    self.email = _email.asObserver()

    let _password = BehaviorSubject<String?>(value: nil)
    self.password = _password.asObserver()

    let _didReceiveLoginError = PublishSubject<LoginErrorInfo>()
    self.didReceiveLoginError = _didReceiveLoginError.asObservable()

    let _didInvalidateLoginCredentials = PublishSubject<LoginErrorInfo>()
    self.didInvalidateLoginCredentials = _didInvalidateLoginCredentials.asObservable()

    let _loggingIn = PublishSubject<Void>()
    self.loggingIn = _loggingIn.asObservable()

    let credentials = Observable.combineLatest(
      _email.asObservable(),
      _password.asObservable()
    ) { Credentials(email: $0, password: $1) }

    let validCredentials = _login
      .asObservable()
      .withLatestFrom(credentials) { _, credentials in return credentials }
      .filter { credentials in

        guard let email = credentials.email, !email.isEmpty else {
          let e = LoginErrorInfo(title: "Email required", message: "Please enter your email")
          _didInvalidateLoginCredentials.onNext(e)
          return false
        }

        guard email.isValidEmail else {
          let e = LoginErrorInfo(title: "Email not valid", message: "Please check the email that you entered")
          _didInvalidateLoginCredentials.onNext(e)
          return false
        }

        guard let password = credentials.password, !password.isEmpty else {
          let e = LoginErrorInfo(title: "Password required", message: "Please enter your password")
          _didInvalidateLoginCredentials.onNext(e)
          return false
        }

        _loggingIn.onNext(Void())
        return true
    }

    self.didLoginSuccessfully = Observable
      .zip(validCredentials, loggingIn.delay(0.5, scheduler: MainScheduler.instance)) { credentials, _ in return credentials }
      .flatMap { credentials in
        return service.login(email: credentials.email!, password: credentials.password!)
          .catchError { error in

            let moyaError = error as? Moya.MoyaError
            let message = moyaError?.endpointResponse?.message ?? "Something went wrong. Please try again."

            let e = LoginErrorInfo(title: "Sign In Attempt", message: message)
            _didReceiveLoginError.onNext(e)
            return Observable.empty()
        }
    }

  }

}
