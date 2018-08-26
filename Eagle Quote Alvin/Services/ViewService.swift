//
//  ViewService.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import PluggableApplicationDelegate

class ViewService: NSObject, ApplicationService {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {

    UIApplication.shared.appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
    UIApplication.shared.appDelegate.window?.makeKeyAndVisible()

    return true
  }

}
