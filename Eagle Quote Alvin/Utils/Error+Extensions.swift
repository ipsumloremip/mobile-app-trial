//
//  Error+Extensions.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import Moya

extension Error where Self == Moya.MoyaError {

  var endpointResponse: EndpointResponse? {
    do {
      guard let json = try self.response?.mapJSON() as? [String: Any],
        let dataJSON = json["data"] as? [String: Any],
        let responseJSON = dataJSON["response"] as? [String: Any] else {
          return nil
      }

      let data = try JSONSerialization.data(withJSONObject: responseJSON)
      return try JSONDecoder().decode(EndpointResponse.self, from: data)
    } catch {
      return nil
    }
  }

}
