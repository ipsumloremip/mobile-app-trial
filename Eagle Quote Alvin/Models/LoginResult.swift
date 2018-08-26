//
//  LoginResult.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

struct LoginResult: Codable {
  
  let response: EndpointResponse
  let authorization: Authorization
  let user: User
  
}
