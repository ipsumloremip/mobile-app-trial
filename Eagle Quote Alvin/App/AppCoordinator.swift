//
//  AppCoordinator.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {

  private weak var window: UIWindow?

  init(window: UIWindow) {
    self.window = window
  }

  override func start() -> Observable<Void> {
    let loginCoordinator = LoginCoordinator(window: window)
    return coordinate(to: loginCoordinator)
  }

}
