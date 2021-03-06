//
//  AuthorizationTests.swift
//  Eagle Quote AlvinTests
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import Eagle_Quote_Alvin

class AuthorizationTests: QuickSpec {
  
  override func spec() {
    
    describe("A authorization model") {
      
      let authorization = DummyData.Authorization().object
      
      context("after being initialized") {
        
        it("can be encoded") {
          
          let encoded = try! JSONEncoder().encode(authorization)
          
          expect(encoded).toNot(beNil())
          
        }
        
      }
      
      it("can be decoded from JSON data") {
        
        let json = DummyData.Authorization().json
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        let decoded = try! JSONDecoder().decode(Authorization.self, from: jsonData)
        
        expect(decoded).toNot(beNil())
        
      }
      
    }
    
  }
  
}
