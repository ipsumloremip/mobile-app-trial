//
//  EndpointResponseTests.swift
//  Eagle Quote AlvinTests
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import Eagle_Quote_Alvin

class EndpointResponseTests: QuickSpec {
  
  override func spec() {
    
    describe("A endpoint response model") {
      
      let code = 200
      let status = "Success"
      let message = "Quotes successfully fetched."
      
      let response = EndpointResponse(
        code: code,
        status: status,
        message: message
      )
      
      context("after being initialized") {
        
        it("can be encoded") {
          
          let encoded = try! JSONEncoder().encode(response)
          
          expect(encoded).toNot(beNil())
          
        }
        
      }
      
      it("can be decoded from JSON data") {
        
        let json: [String: Codable] = [
          "code": code,
          "status": status,
          "message": message
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        let decoded = try! JSONDecoder().decode(EndpointResponse.self, from: jsonData)
        
        expect(decoded).toNot(beNil())
        
      }
      
    }
    
  }
  
}
