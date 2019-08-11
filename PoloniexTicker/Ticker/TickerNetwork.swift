//
//  TickerNetwork.swift
//  PoloniexTicker
//
//  Created by ViXette on 09/08/2019.
//  Copyright © 2019 ViXette. All rights reserved.
//

import Foundation
import RxSwift

struct TickerNetwork {
    func fetchTickers() -> Observable<Tickers> {
        var urlComponents = URLComponents(string: ConfigUrl.baseApiUrl)
        urlComponents?.queryItems = [URLQueryItem(name: "command", value: "returnTicker")]

        guard let url = urlComponents?.url else {
            return Observable.error(RequestError.emptyUrl)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return Network.shared
            .response(Tickers.self, request: request)
            .map({ $0 })
    }
}
