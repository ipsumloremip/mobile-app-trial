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
    let createdAt = "2018-08-26T07:45:05.1538473"
    let clients = [DummyData.Client().object]

    var json: [String: Codable] {
      return [
        "quoteId": quoteId,
        "createdAt": createdAt,
        "clients": [DummyData.Client().json]
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

extension DummyData {

  struct EndpointPaging: StubbedModelType {

    let page = 1
    let perPage = 20
    let size = 3
    let records = 3

    var json: [String: Codable] {
      return [
        "page": page,
        "perPage": perPage,
        "size": size,
        "records": records
      ]
    }

    var object: Eagle_Quote_Alvin.EndpointPaging {
      return Eagle_Quote_Alvin.EndpointPaging(
        page: page,
        perPage: perPage,
        size: size,
        records: records
      )
    }

  }
}

extension DummyData {

  struct EndpointResponse: StubbedModelType {

    let code = 200
    let status = "Success"
    let message = "Quotes successfully fetched."

    var json: [String: Codable] {
      return [
        "code": code,
        "status": status,
        "message": message
      ]
    }

    var object: Eagle_Quote_Alvin.EndpointResponse {
      return Eagle_Quote_Alvin.EndpointResponse(
        code: code,
        status: status,
        message: message
      )
    }

  }
}

extension DummyData {
  
  struct QuotesResult: StubbedModelType {
    
    let quotes = [ DummyData.Quote().object ]
    let paging = DummyData.EndpointPaging().object
    let response = DummyData.EndpointResponse().object
    
    var json: [String: Codable] {
      return [
        "quotes": [ DummyData.Quote().json ],
        "paging": DummyData.EndpointPaging().json,
        "response": DummyData.EndpointResponse().json
      ]
    }
    
    var object: Eagle_Quote_Alvin.QuotesResult {
      return Eagle_Quote_Alvin.QuotesResult(
        quotes: quotes,
        paging: paging,
        response: response
      )
    }
    
  }
}

extension DummyData {
  
  struct Authorization: StubbedModelType {
    
    let token = DummyData.AccessToken().token
    let validTo = "2018-08-29T05:28:39Z"
    let sessionToken = DummyData.AccessToken().object
    let refreshToken = DummyData.AccessToken().object
    
    var json: [String: Codable] {
      return [
        "token": token,
        "validTo": validTo,
        "sessionToken": DummyData.AccessToken().json,
        "refreshToken": DummyData.AccessToken().json,
      ]
    }
    
    var object: Eagle_Quote_Alvin.Authorization {
      return Eagle_Quote_Alvin.Authorization(
        token: token,
        validTo: validTo,
        sessionToken: sessionToken,
        refreshToken: refreshToken
      )
    }
    
  }
}

extension DummyData {
  
  struct User: StubbedModelType {
    
    let id = "f30cb301-0dea-4253-85f5-006039cac9e4"
    let email = "alvinjaycosare@gmail.com"
    let fspr = "FSP123456"
    let fullName = "Alvin"
    let createdAt = "2018-08-25T08:55:47.5446334"
    let updatedAt = "2018-08-25T08:55:47.5446338"
    
    var json: [String: Codable] {
      return [
        "id": id,
        "email": email,
        "fspr": fspr,
        "fullName": fullName,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      ]
    }
    
    var object: Eagle_Quote_Alvin.User {
      return Eagle_Quote_Alvin.User(
        id: id,
        email: email,
        fspr: fspr,
        fullName: fullName,
        createdAt: createdAt,
        updatedAt: updatedAt
      )
    }
    
  }
}

extension DummyData {
  
  struct LoginResult: StubbedModelType {
    
    let response = DummyData.EndpointResponse().object
    let authorization = DummyData.Authorization().object
    let user = DummyData.User().object
    
    var json: [String: Codable] {
      return [
        "response": DummyData.EndpointResponse().json,
        "authorization": DummyData.Authorization().json,
        "user": DummyData.User().json
      ]
    }
    
    var object: Eagle_Quote_Alvin.LoginResult {
      return Eagle_Quote_Alvin.LoginResult(
        response: response,
        authorization: authorization,
        user: user
      )
    }
    
  }
}

extension DummyData {
  
  struct QuoteEmailRecipient: StubbedModelType {
    
    let email = "ipsumloremip@gmail.com"
    let type: Eagle_Quote_Alvin.QuoteEmail.Recipient.InputType = .to
    
    var json: [String: Codable] {
      return [:]
    }
    
    var object: Eagle_Quote_Alvin.QuoteEmail.Recipient {
      return Eagle_Quote_Alvin.QuoteEmail.Recipient(
        email: email,
        name: nil,
        type: type
      )
    }
    
  }
  
}

extension DummyData {
  
  struct QuoteEmail: StubbedModelType {
    
    let recipients = [ DummyData.QuoteEmailRecipient().object ]
    let subject = "Dynamic Send Email Example"
    let body = "Example Text Body. . . ."
    let quoteId = 15101
    
    var json: [String: Codable] {
      return [:]
    }
    
    var object: Eagle_Quote_Alvin.QuoteEmail {
      return Eagle_Quote_Alvin.QuoteEmail(
        recipients: recipients,
        replyTo: nil,
        subject: subject,
        body: body,
        quoteId: quoteId
      )
    }
    
  }
  
}
