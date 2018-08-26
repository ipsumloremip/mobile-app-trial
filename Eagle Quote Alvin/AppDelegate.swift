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
  
  let viewService = ViewService()
  let keychainService = KeychainService()

  override var services: [ApplicationService] {
    return [viewService, keychainService]
  }

}

extension UIApplication {
  
  var appDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
  }
  
}
