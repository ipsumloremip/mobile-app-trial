//
//  QuoteTests.swift
//  Eagle Quote AlvinTests
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import Quick
import Nimble
import Timepiece

@testable import Eagle_Quote_Alvin

class QuoteTests: QuickSpec {

  override func spec() {

    describe("A quote model") {

      let quote = DummyData.Quote().object
      
      context("after being initialized") {

        it("can be encoded") {

          let encoded = try! JSONEncoder().encode(quote)

          expect(encoded).toNot(beNil())

        }
        
        it("can represent createdAt as Date") {
          
          expect(quote.createdAtDate).toNot(beNil())
          
        }
        
        it("should represent createdAt as the correct Date") {
          
          let string = quote.createdAtDate!.stringIn(dateStyle: .full, timeStyle: .full)
          expect(string == quote.createdAt).toNot(beNil())
          
        }

      }

      it("can be decoded from JSON data") {

        let json = DummyData.Quote().json

        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)

        let decoded = try! JSONDecoder().decode(Quote.self, from: jsonData)

        expect(decoded).toNot(beNil())

      }

    }

  }

}
