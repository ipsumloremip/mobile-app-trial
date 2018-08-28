//
//  Client.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

struct Client: Codable {
  
  let id: Int
  let name: String
  let gender: String
  let age: Int
  let occupationId: Int
  let employedStatus: String
  let isSmoker: Bool
  let isChild: Bool
  let isPrimary: Bool
  let premiums: Premiums
  
}

extension Client {
  
  var isMale: Bool {
    return gender == "M"
  }
  
}
