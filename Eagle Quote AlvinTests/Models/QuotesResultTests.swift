//
//  QuotesResultTests.swift
//  Eagle Quote AlvinTests
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import Eagle_Quote_Alvin

class QuotesResultTests: QuickSpec {
  
  override func spec() {
    
    describe("A quotes result model") {
      
      let response = DummyData.QuotesResult().object
      
      context("after being initialized") {
        
        it("can be encoded") {
          
          let encoded = try! JSONEncoder().encode(response)
          
          expect(encoded).toNot(beNil())
          
        }
        
      }
      
      it("can be decoded from JSON data") {
        
        let json = DummyData.QuotesResult().json
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        let decoded = try! JSONDecoder().decode(QuotesResult.self, from: jsonData)
        
        expect(decoded).toNot(beNil())
        
      }
      
    }
    
  }
  
}
