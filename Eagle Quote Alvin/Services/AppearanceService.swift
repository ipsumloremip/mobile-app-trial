//
//  AppearanceService.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

import PluggableApplicationDelegate
import SVProgressHUD

class AppearanceService: NSObject, ApplicationService {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
    
    setupStatusBar()
    setupNavBar()
    setupSVProgressHUDAppearance()
    
    return true
  }

  private func setupStatusBar() {
    UIApplication.shared.statusBarStyle = .lightContent
  }

  private func setupNavBar() {
    UINavigationBar.appearance().isTranslucent = false
    UINavigationBar.appearance().barTintColor = UIColor.EagleQuote.primary
    UINavigationBar.appearance().tintColor = UIColor.white
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

    UINavigationBar.appearance().shouldCastShadow = true
  }

  private func setupSVProgressHUDAppearance() {
    SVProgressHUD.appearance().defaultMaskType = .black
    SVProgressHUD.appearance().minimumDismissTimeInterval = 3.0
  }

}

extension UINavigationBar {

  var shouldCastShadow: Bool {
    get { return false }
    set {
      if newValue {
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.shadowImage = UIImage()
      }
    }
  }
}

