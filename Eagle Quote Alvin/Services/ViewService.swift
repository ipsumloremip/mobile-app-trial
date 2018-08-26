//
//  ViewService.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import PluggableApplicationDelegate

import RxSwift

class ViewService: NSObject, ApplicationService {
  
  private var appCoordinator: AppCoordinator!
  private let disposeBag = DisposeBag()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {

    let window = UIWindow(frame: UIScreen.main.bounds)
    UIApplication.shared.appDelegate.window = window
    appCoordinator = AppCoordinator(window: window)
    UIApplication.shared.appDelegate.window?.makeKeyAndVisible()

    appCoordinator.start()
      .subscribe()
      .disposed(by: disposeBag)
    
    return true
  }

}
