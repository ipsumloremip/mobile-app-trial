//
//  SideDrawerViewModel.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import RxSwift

protocol SideDrawerViewModelInput {
  var signoutTapped: AnyObserver<Void> { get }
  var confirmSignout: AnyObserver<Void> { get }
}

protocol SideDrawerViewModelOutput {
  var signingOut: Observable<Void> { get }
  var didTapSignout: Observable<Void> { get }
  var didSucessfullySignout: Observable<Void> { get }
}

protocol SideDrawerViewModelType {
  var input: SideDrawerViewModelInput { get }
  var output: SideDrawerViewModelOutput { get }
}

class SideDrawerViewModel: SideDrawerViewModelType, SideDrawerViewModelInput, SideDrawerViewModelOutput {

  var input: SideDrawerViewModelInput { return self }
  var output: SideDrawerViewModelOutput { return self }

  // MARK: Input
  var signoutTapped: AnyObserver<Void>
  var confirmSignout: AnyObserver<Void>

  // MARK: Output
  var signingOut: Observable<Void>
  var didTapSignout: Observable<Void>
  var didSucessfullySignout: Observable<Void>

  init(user: User, token: String, service: APIServiceType = APIService()) {

    let _signoutTapped = PublishSubject<Void>()
    self.signoutTapped = _signoutTapped.asObserver()
    self.didTapSignout = _signoutTapped.asObservable()
    
    let _confirmSignout = PublishSubject<Void>()
    self.confirmSignout = _confirmSignout.asObserver()

    let _signingOut = PublishSubject<Void>()
    self.signingOut = _signingOut.asObservable()
    
    self.signingOut = _confirmSignout.asObservable()

    self.didSucessfullySignout = signingOut
      .flatMap { _ in
        return service.logout(email: user.email, token: token)
          .catchError { error in
            // TODO
            return Observable.empty()
        }
    }

  }

}
