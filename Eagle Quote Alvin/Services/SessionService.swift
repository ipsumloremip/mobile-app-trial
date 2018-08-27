//
//  SessionService.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import PluggableApplicationDelegate

class SessionService: NSObject, ApplicationService {
  
  private struct Keys {
    static let LoggedInUser = "SessionService:Keys:LoggedInUser"
    static let AccessToken = "SessionService:Keys:AccessToken"
  }
  
  
  var hasSession: Bool {
    guard let _ = user else {
      return false
    }
    return true
  }
  
  private(set) var token: String? {
    get {
      return UIApplication.shared.appDelegate.keychainService.get(Keys.AccessToken)
    }
    set(newAccessToken) {
      UIApplication.shared.appDelegate.keychainService.set(securedValue: newAccessToken, key: Keys.AccessToken)
    }
  }
  
  private(set) var user: User? {
    didSet {
      guard let user = user else {
        return UserDefaults.standard.set(nil, forKey: Keys.LoggedInUser)
      }
      
      let wrappedUser = try! JSONEncoder().encode(user)
      UserDefaults.standard.set(wrappedUser, forKey: Keys.LoggedInUser)
      
    }
  }
  
  override init() {
    if let userData = UserDefaults.standard.object(forKey: Keys.LoggedInUser) as? Data {
      do {
        self.user = try JSONDecoder().decode(User.self, from: userData)
      } catch {
        self.user = nil
      }
    }
  }
  
}

extension SessionService {
  
  func login(user: User, with authorization: Authorization) {
    self.user = user
    self.token = authorization.token
  }
  
}
