//
//  UILabel+Extension.swift
//  PoloniexTicker
//
//  Created by ViXette on 11/08/2019.
//  Copyright © 2019 ViXette. All rights reserved.
//

import UIKit

extension UILabel {
    static func initForTitle(size: CGFloat, bold: Bool) -> UILabel {
        let label = UILabel()
        label.font = bold ? .boldSystemFont(ofSize: size) : .systemFont(ofSize: size)
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }
}
