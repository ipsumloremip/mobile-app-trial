//
//  APIService.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import Moya
import RxSwift

enum Result<T, E> {
  case success(T)
  case error(E)
}


class APIService: APIServiceType {

  private var provider: MoyaProvider<EagleQuoteAPI>

  init(provider: MoyaProvider<EagleQuoteAPI> = MoyaProvider<EagleQuoteAPI>()) {
    self.provider = provider
  }

  func login(email: String, password: String) -> Observable<LoginResult> {
    return provider.rx.request(.login(
      email: email,
      password: password)
    )
      .map(LoginResult.self, atKeyPath: "data")
      .asObservable()
  }

  func logout(email: String, token: String) -> Observable<Void> {
    return provider.rx.request(.logout(
      email: email,
      token: token)
    )
      .map { _ in Void() }
      .asObservable()
  }

}

