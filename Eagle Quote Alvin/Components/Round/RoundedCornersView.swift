//
//  RoundedCornersView.swift
//  Eagle Quote AlvinTests
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import UIKit

class RoundedCornersView: UIView, RoundedCornersProtocol {

  @IBInspectable
  var borderColor: UIColor?

  @IBInspectable
  var borderWidth: CGFloat = 1
  
  @IBInspectable
  var cornerRadius: CGFloat = 5

  override func awakeFromNib() {
    setup()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    setup()
  }

  func setup() {
    layer.cornerRadius = cornerRadius
    layer.borderColor = borderColor?.cgColor
    layer.borderWidth = borderWidth
  }

}
