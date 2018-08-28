//
//  SendQuoteEmailCoordinator.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import RxSwift

class SendQuoteEmailCoordinator: BaseCoordinator<Void> {
  
  private weak var window: UIWindow?
  
  init(window: UIWindow?) {
    self.window = window
  }
  
  override func start() -> Observable<Void> {
    
    let vc = SendQuoteEmailController(nibName: "SendQuoteEmailController", bundle: nil)

    let nc = self.window?.rootViewController as! UINavigationController
    nc.pushViewController(vc, animated: true)
    
    
    return Observable.never()
  }
  
}
