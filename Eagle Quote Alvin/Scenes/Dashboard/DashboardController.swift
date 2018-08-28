//
//  DashboardController.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa
import RxOptional

class DashboardController: UIViewController {

  @IBOutlet weak var staticView: UIView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  var viewModel: DashboardViewModelType!

  private var refreshControl: UIRefreshControl!
  private let fabButton = FabButton()
  private let disposeBag = DisposeBag()
  
  private var drawerBarButton: UIBarButtonItem!

  private let tableCoordinator = DashboardTableCoordinator()

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    bind()
    refresh()
  }

  private func setup() {
    setupNavbar()

    attach(fabButton: fabButton)

    tableView.isHidden = true
    staticView.isHidden = true

    tableCoordinator.tableView = tableView

    setupTable()
  }

  private func setupNavbar() {
    title = "Dashboard"
    let drawerBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-menu"), style: .plain, target: self, action: nil)
    navigationItem.leftBarButtonItem = drawerBarButton
    self.drawerBarButton = drawerBarButton
    
    // TODO action
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-search"), style: .plain, target: self, action: nil)
  }

  private func setupTable() {
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    tableView.addSubview(refreshControl)
  }

  private func bind() {
    bindData()
    bindUI()
  }

  private func bindData() {

    let data = viewModel.output.sectionViewModels
    let nonEmptyData = data!.filterEmpty()
    let emptyData = data!.filter { $0.isEmpty }

    data!
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] _ in
        self?.activityIndicator.stopAnimating()
      })
      .disposed(by: disposeBag)

    nonEmptyData
      .observeOn(MainScheduler.instance)
      .map { _ in return false }
      .bind(to: tableView.rx.isHidden)
      .disposed(by: disposeBag)

    nonEmptyData
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] data in
        self?.tableCoordinator.reload(with: data)
      })
      .disposed(by: disposeBag)

    emptyData
      .observeOn(MainScheduler.instance)
      .map { _ in return false }
      .bind(to: staticView.rx.isHidden)
      .disposed(by: disposeBag)

  }

  private func bindUI() {

    viewModel.output.isRefreshing
      .skip(1)
      .bind(to: refreshControl.rx.isRefreshing)
      .disposed(by: disposeBag)
    
    drawerBarButton.rx.tap
      .bind(to: viewModel.input.drawerButtonTapped)
      .disposed(by: disposeBag)

//    tableView.rx.reachedBottom
//      .distinctUntilChanged()
//      .throttle(0.5, scheduler: MainScheduler.instance)
//      .skipUntil(viewModel.output.isRefreshing)
//      .bind(to: viewModel.input.loadMore)
//      .disposed(by: disposeBag)

  }

  override func fabButtonTapped() {
    // noop
  }

  @objc private func refresh() {
    viewModel.input.refresh()
  }

}
