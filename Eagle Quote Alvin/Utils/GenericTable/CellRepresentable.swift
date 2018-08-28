//
//  CellRepresentable.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

/**
 *  This protocol defines what a cell view model should implement. All cell view models should
 *  conform to this protocol so that the view controller will be agnostic of cell view model
 *  behavior.
 */
public protocol CellRepresentable {
  static func registerCell(tableView: UITableView)
  func cellInstance(for tableView: UITableView, in indexPath: IndexPath) -> UITableViewCell
  func cellSelected(in tableView: UITableView)
  func cellDeselected(in tableView: UITableView)
  func willDisplay(_ cell: UITableViewCell, in tableView: UITableView)
  func heightForCell(in tableView: UITableView) -> CGFloat
  func cellEditActions(in tableView: UITableView, at indexPath: IndexPath) -> [UITableViewRowAction]?
  func canEditRow(in tableView: UITableView, at indexPath: IndexPath) -> Bool
  func editingStyle() -> UITableViewCellEditingStyle
  func commitEditAction(with style: UITableViewCellEditingStyle, in tableView: UITableView, at indexPath: IndexPath)
}

extension CellRepresentable {
  
  func cellSelected(in tableView: UITableView) {
    // noop
  }
  
  func cellDeselected(in tableView: UITableView) {
    // noop
  }
  
  func cellEditActions(in tableView: UITableView, at indexPath: IndexPath) -> [UITableViewRowAction]? {
    return nil
  }
  
  func canEditRow(in tableView: UITableView, at indexPath: IndexPath) -> Bool {
    return false
  }
  
  func editingStyle() -> UITableViewCellEditingStyle {
    return .none
  }
  
  func commitEditAction(with style: UITableViewCellEditingStyle, in tableView: UITableView, at indexPath: IndexPath) {
    // noop
  }
  
}
