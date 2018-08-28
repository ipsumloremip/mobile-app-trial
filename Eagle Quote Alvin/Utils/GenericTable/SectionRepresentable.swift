//
//  SectionRepresentable.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

/**
 *  This protocol defines what a section view model should implement. All section view models should
 *  conform to this protocol so that the view controller will be agnostic of section view model
 *  behavior.
 */
public protocol SectionRepresentable {
  
  var cellViewModels: [CellRepresentable] { get set }
  
  static func registerCells(tableView: UITableView)
  
  func headerViewInSection(of tableView: UITableView) -> UIView?
  
  func heightForHeaderInSection(of tableView: UITableView) -> CGFloat
  
  func willDisplay(headerView: UIView, in tableView: UITableView)
  
  func footerViewInSection(of tableView: UITableView) -> UIView?
  
  func heightForFooterInSection(of tableView: UITableView) -> CGFloat
  
  func willDisplay(footerView: UIView, in tableView: UITableView)
  
}

extension SectionRepresentable {
  
  func headerViewInSection(of tableView: UITableView) -> UIView? {
    return nil
  }
  
  func heightForHeaderInSection(of tableView: UITableView) -> CGFloat {
    return 0
  }
  
  func willDisplay(headerView: UIView, in tableView: UITableView) {
    // noop
  }
  
  func footerViewInSection(of tableView: UITableView) -> UIView? {
    return nil
  }
  
  func heightForFooterInSection(of tableView: UITableView) -> CGFloat {
    return 0
  }
  
  func willDisplay(footerView: UIView, in tableView: UITableView) {
    // noop
  }
  
}
