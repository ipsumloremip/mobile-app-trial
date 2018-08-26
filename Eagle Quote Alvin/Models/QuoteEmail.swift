//
//  QuoteEmail.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

struct QuoteEmail: Codable {
  
  let recipients: [QuoteEmail.Recipient]
  let replyTo: String?
  let subject: String
  let body: String
  let quoteId: Int
  
  enum CodingKeys: String, CodingKey {
    case recipients
    case replyTo = "replyto"
    case subject
    case body
    case quoteId
  }
  
}

extension QuoteEmail {
  
  struct Recipient: Codable {
    
    enum InputType: String, Codable {
      case to
      case cc
    }
    
    let email: String
    let name: String?
    let type: InputType
    
  }
  
}
