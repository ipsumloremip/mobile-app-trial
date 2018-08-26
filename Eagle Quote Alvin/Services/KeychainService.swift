//
//  KeychainService.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import KeychainAccess
import PluggableApplicationDelegate

class KeychainService: NSObject, ApplicationService {
  
  private let keychain = Keychain(service: "com.blackfin.EagleQuoteAlvin")
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
    return true
  }
  
  func set(securedValue: String?, key: String) {
    keychain[key] = securedValue
  }
  
  func get(_ key: String) -> String? {
    return try! keychain.getString(key)
  }
  
}



