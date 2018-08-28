//
//  DashboardTableCoordinator.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

class DashboardTableCoordinator: GenericTableCoordinator {
  
  override func setupTable() {
    super.setupTable()
    
    tableView.separatorInset = .zero
    tableView.separatorColor = self.tableView.backgroundColor
    
    DashboardQuoteSectionViewModel.registerCells(tableView: tableView)
    tableView.tableFooterView = UIView()
    
  }
  
}
