//
//  UIViewController+FabButton.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import UIKit

extension UIViewController {
  
  func attach(fabButton: FabButton) {
    view.addSubview(fabButton)
    fabButton.snp.makeConstraints { make in
      make.trailing.bottom.equalToSuperview().inset(30)
    }
    fabButton.addTarget(self, action: #selector(UIViewController.fabButtonTapped), for: .touchUpInside)
  }
  
  @objc
  func fabButtonTapped() {
    preconditionFailure("Must override fabButtonTapped in subclasses")
  }
  
}
