//
//  QuoteEmailRecipientTests.swift
//  Eagle Quote AlvinTests
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import Eagle_Quote_Alvin

class QuoteEmailRecipientTests: QuickSpec {
  
  override func spec() {
    
    describe("A quote email recipient model") {
      
      let result = DummyData.QuoteEmailRecipient().object
      
      context("after being initialized") {
        
        it("can be encoded") {
          
          let encoded = try! JSONEncoder().encode(result)
          
          expect(encoded).toNot(beNil())
          
        }
        
      }
      
    }
    
    describe("A quote email model") {
      
      let result = DummyData.QuoteEmail().object
      
      context("after being initialized") {
        
        it("can be encoded") {
          
          let encoded = try! JSONEncoder().encode(result)
          
          expect(encoded).toNot(beNil())
          
        }
        
      }
      
    }
    
  }
  
}

