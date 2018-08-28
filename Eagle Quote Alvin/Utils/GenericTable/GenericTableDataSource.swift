//
//  GenericTableDataSource.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

class GenericTableDataSource: NSObject, UITableViewDataSource {
  
  var sectionViewModels: [SectionRepresentable] = []
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sectionViewModels.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let sectionViewModel = sectionViewModels[section]
    return sectionViewModel.cellViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let sectionViewModel = sectionViewModels[indexPath.section]
    let cellViewModel = sectionViewModel.cellViewModels[indexPath.row]
    return cellViewModel.cellInstance(for: tableView, in: indexPath)
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    let sectionViewModel = sectionViewModels[indexPath.section]
    let cellViewModel = sectionViewModel.cellViewModels[indexPath.row]
    return cellViewModel.canEditRow(in: tableView, at: indexPath)
  }
  
}
