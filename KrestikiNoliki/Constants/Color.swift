//
//  Color.swift
//  KrestikiNoliki
//
//  Created by Medeu Pazylov on 08.04.2024.
//

import UIKit

struct Color {
  static var foregroundTitleColor = UIColor(197,180,227)
  static var backgroundColor = UIColor(85, 62, 107)
  static var buttonColor = UIColor(55,39,69)
}

extension UIColor {
  convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) {
    self.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
  }
}
