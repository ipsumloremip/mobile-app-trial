//
//  DashboardQuoteSectionViewModel.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import  UIKit

protocol DashboardQuoteSectionViewModelType: SectionRepresentable {}

class DashboardQuoteSectionViewModel: DashboardQuoteSectionViewModelType {
  
  var cellViewModels: [CellRepresentable]
  
  private(set) var headerViewModel: DashboardQuoteSectionHeaderViewModelType!
  
  init(cellViewModels: [DashboardClientCellViewModelType]) {
    
    let date = cellViewModels.first!.output.quote.createdAtDate!
    self.headerViewModel = DashboardQuoteSectionHeaderViewModel(date: date)
    
    self.cellViewModels = cellViewModels
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
