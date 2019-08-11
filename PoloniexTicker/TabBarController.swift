//
//  TabBarController.swift
//  PoloniexTicker
//
//  Created by ViXette on 09/08/2019.
//  Copyright © 2019 ViXette. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barStyle = .black
        tabBar.tintColor = .white

        let tickerViewController = TickerViewController(viewModel: TickerViewModel(network: TickerNetwork()))
        let emptyViewController = EmptyViewController()
        viewControllers = [tickerViewController, emptyViewController].map { UINavigationController(rootViewController: $0) }

        setupTabBarItems()
    }
    
    private func setupTabBarItems() {
        if let item = tabBar.items?[0] {
            item.image = UIImage(named: "stocks")?.resizeImage(targetHeight: 20)?.withRenderingMode(.alwaysTemplate)
        }
        if let item = tabBar.items?[1] {
            item.image = UIImage(named: "empty")?.resizeImage(targetHeight: 20)?.withRenderingMode(.alwaysTemplate)
        }
    }
}
