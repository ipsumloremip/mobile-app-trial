//
//  DashboardCoordinator.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import RxSwift

class DashboardCoordinator: BaseCoordinator<Void> {
  
  private weak var window: UIWindow?
  
  init(window: UIWindow?) {
    self.window = window
  }
  
  override func start() -> Observable<Void> {
    
    let vc = DashboardController(nibName: "DashboardController", bundle: nil)
    let nc = UINavigationController(rootViewController: vc)
    
    window?.rootViewController = nc
    
    return Observable.never()
  }
  
}
