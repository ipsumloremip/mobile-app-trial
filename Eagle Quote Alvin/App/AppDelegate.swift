//
//  AppDelegate.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import UIKit

import PluggableApplicationDelegate

@UIApplicationMain
class AppDelegate: PluggableApplicationDelegate {
  
  let appearanceService = AppearanceService()
  let viewService = ViewService()
  let keychainService = KeychainService()
  let sessionService = SessionService()

  override var services: [ApplicationService] {
    return [appearanceService, viewService, keychainService, sessionService]
  }

}

extension UIApplication {
  
  var appDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
  }
  
}
