//
//  UIImage+Extensions.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
  
  func tinted(color: UIColor) -> UIImage {
    
    UIGraphicsBeginImageContext(self.size)
    guard let context = UIGraphicsGetCurrentContext() else { return self }
    guard let cgImage = cgImage else { return self }
    
    // flip the image
    context.scaleBy(x: 1.0, y: -1.0)
    context.translateBy(x: 0.0, y: -size.height)
    
    // multiply blend mode
    context.setBlendMode(.multiply)
    
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    context.clip(to: rect, mask: cgImage)
    color.setFill()
    context.fill(rect)
    
    // create uiimage
    guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return self }
    UIGraphicsEndImageContext()
    
    return newImage
    
  }
  
}
