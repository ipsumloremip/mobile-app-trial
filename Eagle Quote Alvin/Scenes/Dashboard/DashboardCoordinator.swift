//
//  DashboardCoordinator.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import RxSwift
import SideMenu

class DashboardCoordinator: BaseCoordinator<Void> {

  private weak var window: UIWindow?
  private weak var navigationController: UINavigationController?
  
  private var result = PublishSubject<Void>()
  private var confirmSignout: AnyObserver<Void>?

  init(window: UIWindow?) {
    self.window = window
  }

  override func start() -> Observable<Void> {
    
    guard let user = UIApplication.shared.appDelegate.sessionService.user,
      let token = UIApplication.shared.appDelegate.sessionService.token else {
      preconditionFailure("There is no logged in user")
    }

    // MARK: Dashboard
    let vm = DashboardViewModel()
    let vc = DashboardController(nibName: "DashboardController", bundle: nil)
    vc.viewModel = vm

    vm.output.didTapQuoteCellOptions
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] quote in
        self?.showActionSheet(for: quote)
      })
      .disposed(by: disposeBag)

    vm.output.didTapDrawerButton
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] _ in
        self?.toggleDrawer()
      })
      .disposed(by: disposeBag)
    
    let nc = UINavigationController(rootViewController: vc)
    
    // MARK: Drawer
    let drawerVM = SideDrawerViewModel(user: user, token: token)
    let drawerVC = SideDrawerController(nibName: "SideDrawerController", bundle: nil)
    drawerVC.viewModel = drawerVM
    
    let drawerNC = UISideMenuNavigationController(rootViewController: drawerVC)
    drawerNC.isNavigationBarHidden = true
    
    SideMenuManager.default.menuLeftNavigationController = drawerNC
    SideMenuManager.default.menuAddPanGestureToPresent(toView: nc.navigationBar)
    SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: nc.view)
    
    drawerVM.output.didTapSignout
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] _ in
        self?.showLogoutConfirmation()
      })
      .disposed(by: disposeBag)
    
    drawerVM.output.didSucessfullySignout
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] _ in
        self?.result.onNext(Void())
      })
      .disposed(by: disposeBag)

    self.confirmSignout = drawerVM.input.confirmSignout

    window?.rootViewController = nc
    navigationController = nc

    return result
  }

}

extension DashboardCoordinator {

  fileprivate func showActionSheet(for quote: Quote) {
    let ac = UIAlertController.actionSheet()
    ac.addAction(UIAlertAction(title: "Send Quote by Email", style: .default, handler: { _ in
      self.showSendEmailPage(for: quote)
    }))
    self.window!.rootViewController!.present(ac, animated: true)
  }

  fileprivate func showSendEmailPage(for quote: Quote) {
    let sendEmailCoordinator = SendQuoteEmailCoordinator(window: window, quote: quote)
    coordinate(to: sendEmailCoordinator)
      .subscribe()
      .disposed(by: disposeBag)
  }

  fileprivate func toggleDrawer() {
    guard let nc = navigationController else { return }
    if SideMenuManager.default.menuLeftNavigationController!.isBeingPresented {
      return nc.dismiss(animated: true, completion: nil)
    }
    nc.present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
  }
  
  fileprivate func showLogoutConfirmation() {
    let ac = UIAlertController.actionSheet(title: "Are you sure?")
    ac.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
      self.confirmSignout?.onNext(Void())
    }))
    SideMenuManager.default.menuLeftNavigationController!.present(ac, animated: true)
  }

}
