//
//  LoginCoordinator.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import RxSwift

class LoginCoordinator: BaseCoordinator<Void> {
  
  private weak var window: UIWindow?
  
  init(window: UIWindow?) {
    self.window = window
  }
  
  override func start() -> Observable<Void> {
    let vc = LoginController(nibName: "LoginController", bundle: nil)
    let nc = UINavigationController(rootViewController: vc)
    
    window?.rootViewController = nc
    
    return Observable.never()
  }
  
}
