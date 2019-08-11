//
//  TickerViewModel.swift
//  PoloniexTicker
//
//  Created by ViXette on 09/08/2019.
//  Copyright © 2019 ViXette. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class TickerViewModel {
    var tickers: [Ticker] = []
    
    var indicesForUpdate: [Int] = []

    let initialUpdateSignal = PublishRelay<()>()
    
    let updateSignal = PublishRelay<()>()

    private let network: TickerNetwork

    private var tickersSubscription: Disposable?

    private let disposeBag = DisposeBag()

    init(network: TickerNetwork) {
        self.network = network
    }

    func subscribeReTickers() {
        tickersSubscription = Observable<Int>
            .timer(RxTimeInterval.seconds(0), period: RxTimeInterval.seconds(5), scheduler: MainScheduler.instance)
            .subscribe { [unowned self] _ in
                self.fetchTickers()
            }
    }

    func unsubscribeReTickers() {
        tickersSubscription?.dispose()
    }
    
    private func fetchTickers() {
        network.fetchTickers()
            //.observeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .utility))

            .subscribe(onNext:{ result in
                // Initial Data
                if self.tickers.count == 0 {
                    self.tickers = result.items.sorted { $0.title < $1.title  }
                    self.initialUpdateSignal.accept(())
                }
                
                // Next Data
                self.indicesForUpdate = []
                for (i, ticker) in result.items.enumerated() {
                    if let foundTicker = self.tickers.filter ({ $0.title == ticker.title }).first {
                        if foundTicker.last != ticker.last || foundTicker.highestBid != ticker.highestBid || foundTicker.percentChange != ticker.percentChange {
                            self.indicesForUpdate.append(i)
                        }
                    } else { // New unique ticker
                        self.indicesForUpdate.append(i)
                    }
                }
                self.tickers = result.items.sorted { $0.title < $1.title  }
                self.updateSignal.accept(())
            })
            .disposed(by: disposeBag)
    }
}