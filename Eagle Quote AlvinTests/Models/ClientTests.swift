//
//  ClientTests.swift
//  Eagle Quote AlvinTests
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import Eagle_Quote_Alvin

class ClientTests: QuickSpec {
  
  override func spec() {
    
    describe("A client model") {
      
      let id = 0
      let name = "Kiki"
      let gender = "M"
      let age = 23
      let occupationId = 1
      let employedStatus = "Employed"
      let isSmoker = false
      let isChild = false
      let isPrimary = true
      let premiums = Premiums(minTotalPremium: 111.29, maxTotalPremium: 138.37)
      
      let client = Client(
        id: id,
        name: name,
        gender: gender,
        age: age,
        occupationId: occupationId,
        employedStatus: employedStatus,
        isSmoker: isSmoker,
        isChild: isChild,
        isPrimary: isPrimary,
        premiums: premiums
      )
      
      context("after being initialized") {
        
        it("can be encoded") {
          
          let encoded = try! JSONEncoder().encode(client)
          
          expect(encoded).toNot(beNil())
          
        }
        
      }
      
      it("can be decoded from JSON data") {
        
        let json: [String: Decodable] = [
          "id": id,
          "name": name,
          "gender": gender,
          "age": age,
          "occupationId": occupationId,
          "employedStatus": employedStatus,
          "isSmoker": isSmoker,
          "isChild": isChild,
          "isPrimary": isPrimary,
          "premiums": [
            "minTotalPremium": 111.29,
            "maxTotalPremium": 138.37
          ]
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        let decoded = try! JSONDecoder().decode(Client.self, from: jsonData)
        
        expect(decoded).toNot(beNil())
        
      }
      
    }
    
  }
  
}
