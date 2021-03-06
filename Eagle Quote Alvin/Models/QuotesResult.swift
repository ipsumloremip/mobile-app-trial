//
//  QuotesResult.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

struct QuotesResult: Codable {
  
  let quotes: [Quote]
  let paging: EndpointPaging
  let response: EndpointResponse
  
}
