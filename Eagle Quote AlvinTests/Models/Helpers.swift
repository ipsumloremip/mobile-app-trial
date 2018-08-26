//
//  Helpers.swift
//  Eagle Quote AlvinTests
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

@testable import Eagle_Quote_Alvin

protocol StubbedModelType {

  associatedtype Model

  var json: [String: Codable] { get }
  var object: Model { get }

}


struct DummyData { }


extension DummyData {

  struct AccessToken: StubbedModelType {

    typealias Model = Eagle_Quote_Alvin.AccessToken

    let token = "240eba01d2624af3a91be8709e4a26c4.f30cb3010dea425385f5006039cac9e4"
    let expiredAt = "2018-10-24T08:55:39.5589944Z"

    var json: [String: Codable] {
      return [
        "token": "",
        "expiredAt": ""
      ]
    }

    var object: Eagle_Quote_Alvin.AccessToken {
      return Eagle_Quote_Alvin.AccessToken(token: token, expiredAt: expiredAt)
    }

  }

}

extension DummyData {

  struct Premiums: StubbedModelType {

    let minTotalPremium: Double = 111.29
    let maxTotalPremium: Double = 138.37

    var json: [String: Codable] {
      return [
        "minTotalPremium": minTotalPremium,
        "maxTotalPremium": maxTotalPremium
      ]
    }

    var object: Eagle_Quote_Alvin.Premiums {
      return Eagle_Quote_Alvin.Premiums(
        minTotalPremium: minTotalPremium,
        maxTotalPremium: maxTotalPremium
      )
    }

  }
}


extension DummyData {

  struct Client: StubbedModelType {

    let id = 0
    let name = "Kiki"
    let gender = "M"
    let age = 23
    let occupationId = 1
    let employedStatus = "Employed"
    let isSmoker = false
    let isChild = false
    let isPrimary = true
    let premiums = DummyData.Premiums().object

    var json: [String: Codable] {
      return [
        "id": id,
        "name": name,
        "gender": gender,
        "age": age,
        "occupationId": occupationId,
        "employedStatus": employedStatus,
        "isSmoker": isSmoker,
        "isChild": isChild,
        "isPrimary": isPrimary,
        "premiums": DummyData.Premiums().json
      ]
    }

    var object: Eagle_Quote_Alvin.Client {

      return Eagle_Quote_Alvin.Client(
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

    }

  }

}

extension DummyData {
  
  struct Quote: StubbedModelType {
    
    let quoteId = 15101
    let createdAt = "2018-08-24T07:40:43.6567811Z"
    let clients = [DummyData.Client().object]
    
    var json: [String: Codable] {
      return [
        "quoteId": quoteId,
        "createdAt": createdAt,
        "clients": [ DummyData.Client().json ]
      ]
    }
    
    var object: Eagle_Quote_Alvin.Quote {
      return Eagle_Quote_Alvin.Quote(
        quoteId: quoteId,
        createdAt: createdAt,
        clients: clients
      )
    }
    
  }
}
