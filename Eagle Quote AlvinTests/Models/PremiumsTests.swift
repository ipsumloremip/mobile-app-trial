//
//  PremiumsTests.swift
//  Eagle Quote AlvinTests
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import Eagle_Quote_Alvin

class PremiumsTests: QuickSpec {
  
  override func spec() {
    
    describe("A premiums model") {
      
      let premiums = DummyData.Premiums().object
      
      context("after being initialized") {
          
        it("can be encoded") {
          
          let encodedPremiums = try! JSONEncoder().encode(premiums)
          
          expect(encodedPremiums).toNot(beNil())
          
        }
        
      }
      
      it("can be decoded from JSON data") {
        
        let json = DummyData.Premiums().json
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        let decodedPremiums = try! JSONDecoder().decode(Premiums.self, from: jsonData)
        
        expect(decodedPremiums).toNot(beNil())
        
      }
      
    }
    
  }
  
}
