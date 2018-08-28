//
//  Date+Extensions.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

extension Date {
  
  static func <=(lhs: Date, rhs: Date) -> Bool {
    let res = lhs.compare(rhs)
    return res == .orderedAscending || res == .orderedSame
  }
  static func >=(lhs: Date, rhs: Date) -> Bool {
    let res = lhs.compare(rhs)
    return res == .orderedDescending || res == .orderedSame
  }
  static func >(lhs: Date, rhs: Date) -> Bool {
    return lhs.compare(rhs) == .orderedDescending
  }
  static func <(lhs: Date, rhs: Date) -> Bool {
    return lhs.compare(rhs) == .orderedAscending
  }
  static func ==(lhs: Date, rhs: Date) -> Bool {
    return lhs.compare(rhs) == .orderedSame
  }
  
}
