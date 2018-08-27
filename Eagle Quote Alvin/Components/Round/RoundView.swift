//
//  RoundView.swift
//  Eagle Quote AlvinTests
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

class RoundView: UIView {

  override func awakeFromNib() {
    super.awakeFromNib()
    onInit()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    onInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    onInit()
  }

  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
    roundify()
  }

  private func onInit() {
    roundify()
  }

  func roundify() {
    let basis = layer.frame.size.height > layer.frame.size.width ? layer.frame.size.width : layer.frame.size.height
    layer.cornerRadius = basis / 2
    layer.masksToBounds = true
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    roundify()
  }

}
