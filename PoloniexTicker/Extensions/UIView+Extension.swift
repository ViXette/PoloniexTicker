//
//  UIView+Extension.swift
//  PoloniexTicker
//
//  Created by ViXette on 10/08/2019.
//  Copyright © 2019 ViXette. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
