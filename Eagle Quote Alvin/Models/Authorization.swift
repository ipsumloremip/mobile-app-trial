//
//  Authorization.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

struct Authorization: Codable {
  
  let token: String
  let validTo: String
  let sessionToken: AccessToken
  let refreshToken: AccessToken
  
}
