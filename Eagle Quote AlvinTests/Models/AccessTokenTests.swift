//
//  AccessTokenTests.swift
//  Eagle Quote AlvinTests
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import Eagle_Quote_Alvin

class AccessTokenTests: QuickSpec {
  
  override func spec() {
    
    describe("An access token model") {
      
      let testToken = ""
      let testExpiredAt = ""
    
      let accessToken = AccessToken(token: testToken, expiredAt: testExpiredAt)
    
      context("after being initialized") {
       
        it("can be encoded") {
          
          let encodedAccessToken = try! JSONEncoder().encode(accessToken)
          
          expect(encodedAccessToken).toNot(beNil())
          
        }
        
      }
      
      it("can be decoded from JSON data") {
        
        let testJSON = [
          "token": testToken,
          "expiredAt": testExpiredAt
        ]
        
        let testJsonData = try! JSONSerialization.data(withJSONObject: testJSON, options: .prettyPrinted)
        
        let decodedAccessToken = try! JSONDecoder().decode(AccessToken.self, from: testJsonData)
        
        expect(decodedAccessToken).toNot(beNil())
        
      }
      
    }
    
  }
  
}
