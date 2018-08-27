//
//  AuthorizedAPIServiceType.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import RxSwift

protocol AuthorizedAPIServiceType {
  
  func fetchQuotes(page: Int, perPage: Int) -> Observable<QuotesResult>
  
  func searchQuotes(search: String, page: Int, perPage: Int, sortBy: String, orderBy: String) -> Observable<QuotesResult>
  
  func sendEmail(emailPayload: QuoteEmail) -> Observable<Void>
  
}
