//
//  LoginResultTests.swift
//  Eagle Quote AlvinTests
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import Eagle_Quote_Alvin

class LoginResultTests: QuickSpec {
  
  override func spec() {
    
    describe("A login result model") {
      
      let result = DummyData.LoginResult().object
      
      context("after being initialized") {
        
        it("can be encoded") {
          
          let encoded = try! JSONEncoder().encode(result)
          
          expect(encoded).toNot(beNil())
          
        }
        
      }
      
      it("can be decoded from JSON data") {
        
        let json = DummyData.LoginResult().json
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        let decoded = try! JSONDecoder().decode(LoginResult.self, from: jsonData)
        
        expect(decoded).toNot(beNil())
        
      }
      
    }
    
  }
  
}
