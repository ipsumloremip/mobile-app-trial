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

@testable import Eagle_Quote_Alvin

class QuoteTests: QuickSpec {

  override func spec() {

    describe("A quote model") {

      let quoteId = 15101
      let createdAt = "2018-08-24T07:40:43.6567811Z"
      let clients = [DummyData.Client().object]

      let quote = Quote(
        quoteId: quoteId,
        createdAt: createdAt,
        clients: clients
      )

      context("after being initialized") {

        it("can be encoded") {

          let encoded = try! JSONEncoder().encode(quote)

          expect(encoded).toNot(beNil())

        }

      }

      it("can be decoded from JSON data") {

        let json: [String: Codable] = [
          "quoteId": quoteId,
          "createdAt": createdAt,
          "clients": [ DummyData.Client().json ]
        ]

        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)

        let decoded = try! JSONDecoder().decode(Quote.self, from: jsonData)

        expect(decoded).toNot(beNil())

      }

    }

  }

}
