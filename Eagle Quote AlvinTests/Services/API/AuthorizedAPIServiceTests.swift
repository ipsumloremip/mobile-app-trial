//
//  AuthorizedAPIServiceTests.swift
//  Eagle Quote AlvinTests
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import Quick
import Nimble

import Moya
import RxSwift

import RxBlocking

@testable import Eagle_Quote_Alvin

class AuthorizedAPIServiceTests: QuickSpec {
  
  override func spec() {
    
    describe("An authorized api service object") {
      
      // Stubbed
      let apiService = AuthorizedAPIService(provider: MoyaProvider<AuthorizedEagleQuoteAPI>(stubClosure: MoyaProvider.immediatelyStub))
      
      // Actual
      //let apiService = AuthorizedAPIService()
      
      context("after being initialized") {
        
        it("can fetch quotes") {
          
          let quotesObservable = apiService.fetchQuotes(page: 1, perPage: 20)
          let quotesResult = try! quotesObservable.toBlocking().toArray()
          
          expect(quotesResult).toNot(beNil())
          
        }
        
        it("can send quote email") {
          
          let sendEmailObservable = apiService.sendEmail(emailPayload: DummyData.QuoteEmail().object)
          let sendEmailCalls = try! sendEmailObservable.toBlocking().toArray()
          
          expect(sendEmailCalls.count) == 1
          
        }
        
      }
      
    }
    
  }
  
}
