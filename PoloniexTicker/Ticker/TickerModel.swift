//
//  TickerModel.swift
//  PoloniexTicker
//
//  Created by ViXette on 09/08/2019.
//  Copyright © 2019 ViXette. All rights reserved.
//

import Foundation

struct Ticker: Decodable {
    let title: String
    let last: String
    let highestBid: String
    let percentChange: String

    enum CodingKeys: CodingKey {
        case last
        case highestBid
        case percentChange
    }

    init(from decoder: Decoder) throws {
        self.title = try decoder.currentTitle()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        last = try container.decode(String.self, forKey: CodingKeys.last)
        highestBid = try container.decode(String.self, forKey: CodingKeys.highestBid)
        percentChange = try container.decode(String.self, forKey: CodingKeys.percentChange)
    }
}

struct Tickers: Decodable {
    let items: [Ticker]
    
    init(from decoder: Decoder) throws {
        self.items = try decoder.decodeTitledElements(Ticker.self)
    }
}