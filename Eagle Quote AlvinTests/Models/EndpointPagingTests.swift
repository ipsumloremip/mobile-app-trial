//
//  EndpointPagingTests.swift
//  Eagle Quote AlvinTests
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import Eagle_Quote_Alvin

class EndpointPagingTests: QuickSpec {

  override func spec() {

    describe("A endpoint paging model") {

      let page = 1
      let perPage = 20
      let size = 3
      let records = 3

      let paging = EndpointPaging(
        page: page,
        perPage: perPage,
        size: size,
        records: records
      )

      context("after being initialized") {

        it("can be encoded") {

          let encoded = try! JSONEncoder().encode(paging)

          expect(encoded).toNot(beNil())

        }

      }

      it("can be decoded from JSON data") {

        let json = [
          "page": page,
          "perPage": perPage,
          "size": size,
          "records": records
        ]

        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)

        let decoded = try! JSONDecoder().decode(EndpointPaging.self, from: jsonData)

        expect(decoded).toNot(beNil())

      }

    }

  }

}
