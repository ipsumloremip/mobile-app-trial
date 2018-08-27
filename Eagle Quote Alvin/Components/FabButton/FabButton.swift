//
//  FabButton.swift
//  Eagle Quote AlvinTests
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import UIKit
import MaterialComponents

class FabButton: MDCFloatingButton {

  var title: String? {
    didSet {
      setTitle(title, for: .normal)
      setTitle(title, for: .selected)
    }
  }
  
  var titleFont: UIFont? {
    didSet {
      setTitleFont(titleFont, for: .normal)
      setTitleFont(titleFont, for: .selected)
    }
  }
  
  var titleColor: UIColor? {
    didSet {
      setTitleColor(titleColor, for: .normal)
      setTitleColor(titleColor, for: .selected)
    }
  }

  override init(frame: CGRect, shape: MDCFloatingButtonShape) {
    super.init(frame: frame, shape: shape)
    onInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    onInit()
  }

  private func onInit() {
    title = "+"
    titleFont = UIFont.systemFont(ofSize: 40)
    titleColor = .white
    setContentEdgeInsets(UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0), for: .default, in: .normal)
    backgroundColor = UIColor.EagleQuote.accent
    
    setShadowColor(shadowColor(for: .normal)!.withAlphaComponent(0.5) , for: .normal)
    setShadowColor(shadowColor(for: .selected)!.withAlphaComponent(0.5) , for: .selected)
  }

}
