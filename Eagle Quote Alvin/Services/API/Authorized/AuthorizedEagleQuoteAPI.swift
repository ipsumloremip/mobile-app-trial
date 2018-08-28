//
//  AuthorizedEagleQuoteAPI.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import Moya

enum AuthorizedEagleQuoteAPI {

  case quotes(
    search: String?,
    page: Int,
    perPage: Int,
    sortBy: QuotesSortByType,
    orderBy: OrderByType
  )

  case sendEmail(
    params: [String: Any]
  )

}

extension AuthorizedEagleQuoteAPI: TargetType {

  var baseURL: URL {
    return URL(string: "https://staging.blackfin.technology/mobile")!
  }

  var path: String {
    switch self {
    case .quotes:
      return "/quote"
    case .sendEmail:
      return "/sendemail"
    }
  }

  var method: Moya.Method {
    switch self {
    case .quotes:
      return .get
    case .sendEmail:
      return .post
    }
  }

  var task: Task {

    switch self {
    case let .quotes(search, page, perPage, sortBy, orderBy):

      var params: [String: Any] = [:]
      params["page"] = page
      params["perPage"] = perPage
      params["sortBy"] = sortBy.type
      params["orderBy"] = orderBy.type

      return .requestParameters(
        parameters: params,
        encoding: URLEncoding.default)

    case let .sendEmail(params):
      return .requestParameters(
        parameters: params,
        encoding: JSONEncoding.default)
    }
  }

  var sampleData: Data {
    switch self {
    case .quotes:
      return stubbedResponse("Quotes")
    default:
      return Data()
    }
  }

  var headers: [String: String]? {
    guard let token = UIApplication.shared.appDelegate.sessionService.token else {
      return [:]
    }
    return ["Authorization": "Bearer \(token)"]
  }

  var validationType: ValidationType {
    return .successAndRedirectCodes
  }
}
