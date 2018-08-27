//
//  EagleQuoteAPI.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import Moya

enum EagleQuoteAPI {

  case login(
    email: String,
    password: String)

  case logout(
    email: String,
    token: String
  )

}

extension EagleQuoteAPI: TargetType {

  var baseURL: URL {
    return URL(string: "https://staging.blackfin.technology/mobile")!
  }

  var path: String {
    switch self {
    case .login:
      return "/LogIn"
    case .logout:
      return "/Logout"
    }
  }

  var method: Moya.Method {
    switch self {
    case .login,
       .logout:
      return .post
    }
  }

  var task: Task {

    switch self {
    case let .login(email, password):

      var params: [String: Any] = [:]
      params["email"] = email
      params["password"] = password
      params["rememberMe"] = true

      return .requestParameters(
        parameters: params,
        encoding: JSONEncoding.default)

    case let .logout(email, token):

      var params: [String: Any] = [:]
      params["email"] = email
      params["token"] = token

      return .requestParameters(
        parameters: params,
        encoding: JSONEncoding.default)
    }
  }

  var sampleData: Data {
    switch self {
    case .login:
      return stubbedResponse("Login")
    default:
      return Data()
    }
  }

  var headers: [String: String]? {
    return [:]
  }

  var validationType: ValidationType {
    return .successAndRedirectCodes
  }
}

func stubbedResponse(_ filename: String) -> Data! {
  @objc class TestClass: NSObject { }
  
  let bundle = Bundle(for: TestClass.self)
  let path = bundle.path(forResource: filename, ofType: "json")
  return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}

