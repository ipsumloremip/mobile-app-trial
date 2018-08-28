//
//  ClassIdentifiable.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

protocol ClassIdentifiable: class {
  static var reuseId: String { get }
}

extension ClassIdentifiable {
  static var reuseId: String {
    return String(describing: self)
  }
}

extension UITableViewCell: ClassIdentifiable {}

extension UITableViewHeaderFooterView: ClassIdentifiable {}
