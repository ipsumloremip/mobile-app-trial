//
//  DashboardQuoteSectionViewModel.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import  UIKit

import RxSwift

protocol DashboardQuoteSectionViewModelInput {}

protocol DashboardQuoteSectionViewModelOutput {
  var didTapQuoteCellOptions: Observable<Quote> { get }
}

protocol DashboardQuoteSectionViewModelType: SectionRepresentable {
  var input: DashboardQuoteSectionViewModelInput { get }
  var output: DashboardQuoteSectionViewModelOutput { get }
}

class DashboardQuoteSectionViewModel: DashboardQuoteSectionViewModelType, DashboardQuoteSectionViewModelInput, DashboardQuoteSectionViewModelOutput {
  
  var input: DashboardQuoteSectionViewModelInput { return self }
  var output: DashboardQuoteSectionViewModelOutput { return self }
  
  
  // MARK: Output
  var didTapQuoteCellOptions: Observable<Quote>
  
  var cellViewModels: [CellRepresentable]
  private(set) var headerViewModel: DashboardQuoteSectionHeaderViewModelType!
  
  private let disposeBag = DisposeBag()
  
  init(cellViewModels: [DashboardClientCellViewModelType]) {
    
    let date = cellViewModels.first!.output.quote.createdAtDate!
    self.headerViewModel = DashboardQuoteSectionHeaderViewModel(date: date)
    self.cellViewModels = cellViewModels
    
    let _didTapQuoteCellOptions = PublishSubject<Quote>()
    self.didTapQuoteCellOptions = _didTapQuoteCellOptions.asObservable()
    
    Observable
      .merge(cellViewModels.map { $0.output.didTapOptions })
      .bind(to: _didTapQuoteCellOptions.asObserver())
      .disposed(by: disposeBag)
    
  }
  
}

extension DashboardQuoteSectionViewModel {
  
  static func registerCells(tableView: UITableView) {
    
    // Cells
    DashboardClientCellViewModel.registerCell(tableView: tableView)
    
    // Header
    tableView.register(DashboardQuoteSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: DashboardQuoteSectionHeaderView.reuseId)

  }
  
  func headerViewInSection(of tableView: UITableView) -> UIView? {
    return tableView.dequeueReusableHeaderFooterView(withIdentifier: DashboardQuoteSectionHeaderView.reuseId)
  }
  
  func heightForHeaderInSection(of tableView: UITableView) -> CGFloat {
    return 40
  }
  
  func willDisplay(headerView: UIView, in tableView: UITableView) {
    if let headerView = headerView as? DashboardQuoteSectionHeaderView {
      headerView.viewModel = self.headerViewModel
    }
  }
  
}
