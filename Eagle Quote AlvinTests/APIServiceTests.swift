//
//  APIServiceTests.swift
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

class APIServiceTests: QuickSpec {
  
  override func spec() {
    
    describe("An api service object") {
      
      var token = ""
      
      // Stubbed
      let apiService = APIService(provider: MoyaProvider<EagleQuoteAPI>(stubClosure: MoyaProvider.immediatelyStub))
        
      // Actual
      // let apiService = APIService()
      
      context("after being initialized") {
        
        it("can login") {
          
          let loginObservable = apiService.login(email: "alvinjaycosare@gmail.com", password: "Password1")
          let loginResult = try! loginObservable.toBlocking().first()
          
          expect(loginResult).toNot(beNil())
          
          token = loginResult!.authorization.token
          
        }
        
        it("can logout") {
          
          let logoutObservable = apiService.logout(email: "alvinjaycosare@gmail.com", token: token)
          let logoutCalls = try! logoutObservable.toBlocking().toArray()
          
          expect(logoutCalls.count == 1)
          
        }
        
      }
      
    }
    
  }
  
}

