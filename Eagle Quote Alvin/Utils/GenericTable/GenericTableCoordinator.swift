//
//  GenericTableCoordinator.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

class GenericTableCoordinator {
  
  private var data: [SectionRepresentable] = []
  let dataSource: GenericTableDataSource
  let delegate: GenericTableDelegate
  
  weak var tableView: UITableView! {
    didSet {
      setupTable()
    }
  }
  
  init(dataSource: GenericTableDataSource = GenericTableDataSource(), delegate: GenericTableDelegate = GenericTableDelegate()) {
    self.dataSource = dataSource
    self.delegate = delegate
  }
  
  internal func setupTable() {
    tableView.dataSource = dataSource
    tableView.delegate = delegate
  }
  
  func reload(with data: [SectionRepresentable]) {
    self.data = data
    dataSource.sectionViewModels = data
    delegate.sectionViewModels = data
    tableView.reloadData()
  }
  
  func deleteRow(at indexPath: IndexPath) {
    var s = data[indexPath.section]
    s.cellViewModels.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .automatic)
  }
  
}
