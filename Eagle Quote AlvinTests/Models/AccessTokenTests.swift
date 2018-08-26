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
      
      let accessToken = DummyData.AccessToken().object
    
      context("after being initialized") {
       
        it("can be encoded") {
          
          let encodedAccessToken = try! JSONEncoder().encode(accessToken)
          
          expect(encodedAccessToken).toNot(beNil())
          
        }
        
      }
      
      it("can be decoded from JSON data") {
        
        let json = DummyData.AccessToken().json
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        let decodedAccessToken = try! JSONDecoder().decode(AccessToken.self, from: jsonData)
        
        expect(decodedAccessToken).toNot(beNil())
        
      }
      
    }
    
  }
  
}
