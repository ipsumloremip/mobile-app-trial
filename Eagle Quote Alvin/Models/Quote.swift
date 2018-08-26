//
//  Quote.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import Timepiece

struct Quote: Codable {
  
  let quoteId: Int
  let createdAt: String
  let clients: [Client]
  
}

extension Quote {
  
  var createdAtDate: Date? {
    return createdAt.date(inFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")
  }
  
}
