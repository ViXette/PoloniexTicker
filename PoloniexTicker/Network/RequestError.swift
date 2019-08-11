//
//  RequestError.swift
//  PoloniexTicker
//
//  Created by ViXette on 09/08/2019.
//  Copyright © 2019 ViXette. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case emptyUrl, unauthorized
}

extension RequestError: CustomStringConvertible {
    var description: String {
        switch self {
        case .unauthorized: return "Запрос не авторизован"
        case .emptyUrl: return "Ошибка создания URL"
        }
    }
}
