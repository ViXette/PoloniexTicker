//
//  URLSession.swift
//  PoloniexTicker
//
//  Created by ViXette on 09/08/2019.
//  Copyright © 2019 ViXette. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension URLSession {
    func response(request: URLRequest) -> Observable<(response: HTTPURLResponse, data: Data)> {
        return self.rx.response(request: request)
    }
}
