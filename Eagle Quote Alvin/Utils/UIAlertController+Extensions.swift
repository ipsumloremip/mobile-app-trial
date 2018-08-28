//
//  UIAlertController+Extensions.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import UIKit

extension UIAlertController {
  
  static func alert(title: String = "", message: String, actionButtonTitle: String = "Ok") -> UIAlertController {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: actionButtonTitle, style: .default, handler: nil)
    ac.addAction(action)
    return ac
  }
  
  static func actionSheet(title: String? = nil, message: String? = nil) -> UIAlertController {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    return ac
  }
  
}
