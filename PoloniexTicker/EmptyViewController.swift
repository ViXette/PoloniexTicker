//
//  EmptyViewController.swift
//  PoloniexTicker
//
//  Created by ViXette on 09/08/2019.
//  Copyright © 2019 ViXette. All rights reserved.
//

import UIKit

class EmptyViewController: UIViewController {
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        title = "Empty"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }
}
