//
//  EndpointPaging.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

struct EndpointPaging: Codable {
  
  let page: Int
  let perPage: Int
  let size: Int
  let records: Int
  
}
