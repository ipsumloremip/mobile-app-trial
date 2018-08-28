//
//  Constants.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

enum QuotesSortByType: String {
  case date
  case firstName = "firstname"
  
  var type: String {
    return rawValue
  }
}

enum OrderByType: String {
  case asc
  case desc
  
  var type: String {
    return rawValue
  }
}
