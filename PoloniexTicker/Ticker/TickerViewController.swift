//
//  TickerViewController.swift
//  PoloniexTicker
//
//  Created by ViXette on 09/08/2019.
//  Copyright © 2019 ViXette. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

class TickerViewController: UIViewController {
    private let viewModel: TickerViewModel
    
    private let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.startAnimating()
        loader.color = .black
        return loader
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TickerTableViewCell.self, forCellReuseIdentifier: tableReuseIdentifier)
        tableView.tableFooterView = UIView()
        return tableView
    }()

    private let tableReuseIdentifier = #file

    private let disposeBag = DisposeBag()

    init(viewModel: TickerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Tickers"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(tableView, loader)
        updateViewConstraints()
        
        setupRx()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.subscribeReTickers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.unsubscribeReTickers()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        loader.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }

    private func setupRx() {
        viewModel.initialUpdateSignal
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] _ in
                self.loader.stopAnimating()
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.updateSignal
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] _ in
                var indexPathsForUpdate: [IndexPath] = []
                self.viewModel.indicesForUpdate.forEach { i in
                    indexPathsForUpdate.append(IndexPath(row: i, section: 0))
                }
                self.tableView.reloadRows(at: indexPathsForUpdate, with: .middle)
            })
            .disposed(by: disposeBag)
    }
}

extension TickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tickers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableReuseIdentifier) as? TickerTableViewCell ?? TickerTableViewCell()
        cell.title = viewModel.tickers[indexPath.row].title
        cell.last = viewModel.tickers[indexPath.row].last
        cell.highest = viewModel.tickers[indexPath.row].highestBid
        cell.percentChange = viewModel.tickers[indexPath.row].percentChange
        return cell
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}