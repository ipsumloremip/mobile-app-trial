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
    
    let vm = DashboardViewModel()
    let vc = DashboardController(nibName: "DashboardController", bundle: nil)
    vc.viewModel = vm
    
    vm.output.didTapQuoteCellOptions
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] quote in
        self?.showActionSheet(for: quote)
      })
      .disposed(by: disposeBag)
    
    let nc = UINavigationController(rootViewController: vc)
    
    window?.rootViewController = nc
    
    return Observable.never()
  }
  
}

extension DashboardCoordinator {
  
  fileprivate func showActionSheet(for quote: Quote) {
    let ac = UIAlertController.actionSheet()
    ac.addAction(UIAlertAction(title: "Send Quote by Email", style: .default , handler:{  _ in
      self.showSendEmailPage(for: quote)
    }))
    self.window!.rootViewController!.present(ac, animated: true)
  }
  
  fileprivate func showSendEmailPage(for quote: Quote) {
    let sendEmailCoordinator = SendQuoteEmailCoordinator(window: window)
    coordinate(to: sendEmailCoordinator)
      .subscribe()
      .disposed(by: disposeBag)
  }
  
}
