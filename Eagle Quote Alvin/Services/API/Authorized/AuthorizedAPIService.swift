//
//  AuthorizedAPIService.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import RxSwift
import Moya

class AuthorizedAPIService: AuthorizedAPIServiceType {

  private var provider: MoyaProvider<AuthorizedEagleQuoteAPI>

  init(provider: MoyaProvider<AuthorizedEagleQuoteAPI> = MoyaProvider<AuthorizedEagleQuoteAPI>()) {
    self.provider = provider
  }


  func fetchQuotes(page: Int, perPage: Int) -> Observable<QuotesResult> {
    return provider.rx.request(.quotes(
      search: nil,
      page: page,
      perPage: perPage,
      sortBy: .date,
      orderBy: .asc)
    )
      .map(QuotesResult.self, atKeyPath: "data")
      .asObservable()
  }

  func searchQuotes(search: String, page: Int, perPage: Int, sortBy: QuotesSortByType, orderBy: OrderByType) -> Observable<QuotesResult> {
    return provider.rx.request(.quotes(
      search: search,
      page: page,
      perPage: perPage,
      sortBy: sortBy,
      orderBy: orderBy)
    )
      .map(QuotesResult.self, atKeyPath: "data")
      .asObservable()
  }

  func sendEmail(emailPayload: QuoteEmail) -> Observable<Void> {

    let data = try! JSONEncoder().encode(emailPayload)
    let params = try! JSONSerialization.jsonObject(with: data) as! [String: Any]

    return provider.rx.request(.sendEmail(params: params)
      )
      .map { _ in Void() }
      .asObservable()
  }

}
