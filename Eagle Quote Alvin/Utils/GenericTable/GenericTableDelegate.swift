//
//  GenericTableDelegate.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

class GenericTableDelegate: NSObject, UITableViewDelegate {
  
  var sectionViewModels: [SectionRepresentable] = []
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let sectionViewModel = sectionViewModels[indexPath.section]
    let cellViewModel = sectionViewModel.cellViewModels[indexPath.row]
    cellViewModel.willDisplay(cell, in: tableView)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let sectionViewModel = sectionViewModels[indexPath.section]
    let cellViewModel = sectionViewModel.cellViewModels[indexPath.row]
    cellViewModel.cellSelected(in: tableView)
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    let sectionViewModel = sectionViewModels[indexPath.section]
    let cellViewModel = sectionViewModel.cellViewModels[indexPath.row]
    cellViewModel.cellDeselected(in: tableView)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let sectionViewModel = sectionViewModels[indexPath.section]
    let cellViewModel = sectionViewModel.cellViewModels[indexPath.row]
    return cellViewModel.heightForCell(in: tableView)
  }
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let sectionViewModel = sectionViewModels[indexPath.section]
    let cellViewModel = sectionViewModel.cellViewModels[indexPath.row]
    return cellViewModel.cellEditActions(in: tableView, at: indexPath)
  }
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    let sectionViewModel = sectionViewModels[indexPath.section]
    let cellViewModel = sectionViewModel.cellViewModels[indexPath.row]
    return cellViewModel.editingStyle()
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    let sectionViewModel = sectionViewModels[indexPath.section]
    let cellViewModel = sectionViewModel.cellViewModels[indexPath.row]
    return cellViewModel.commitEditAction(with: editingStyle, in: tableView, at: indexPath)
  }
  
}

// MARK: Header/Footer
extension GenericTableDelegate {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let sectionViewModel = sectionViewModels[section]
    return sectionViewModel.headerViewInSection(of: tableView)
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    
    let sectionViewModel = sectionViewModels[section]
    return sectionViewModel.footerViewInSection(of: tableView)
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    let sectionViewModel = sectionViewModels[section]
    return sectionViewModel.heightForHeaderInSection(of: tableView)
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    let sectionViewModel = sectionViewModels[section]
    return sectionViewModel.heightForFooterInSection(of: tableView)
  }
  
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    let sectionViewModel = sectionViewModels[section]
    sectionViewModel.willDisplay(headerView: view, in: tableView)
  }
  
  func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
    let sectionViewModel = sectionViewModels[section]
    sectionViewModel.willDisplay(footerView: view, in: tableView)
  }
  
}


