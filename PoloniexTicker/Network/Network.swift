//
//  Network.swift
//  PoloniexTicker
//
//  Created by ViXette on 09/08/2019.
//  Copyright © 2019 ViXette. All rights reserved.
//

import Foundation
import RxSwift

struct Network {
    static let shared = Network()
    
    private init() { }
    
    func response<T: Decodable>(_ type: T.Type, request: URLRequest) -> Observable<T> {
        return URLSession.shared
        	.response(request: request)
            .flatMap { (response, data) -> Observable<T> in
                do {
                    guard 200...203 ~= response.statusCode else {
                        throw RequestError.unauthorized
                    }
                    
                    return .just(try JSONDecoder().decode(type, from: data))
                } catch {
                    return .error(error)
                }
        	}
    }
}
