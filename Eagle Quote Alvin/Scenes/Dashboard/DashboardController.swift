//
//  DashboardController.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

class DashboardController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
  private func setup() {
    title = "Dashboard"
    setupNavbar()
  }
  
  private func setupNavbar() {
    // TODO action
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-menu"), style: .plain, target: self, action: nil)
    // TODO action
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-search"), style: .plain, target: self, action: nil)
  }
  
}
