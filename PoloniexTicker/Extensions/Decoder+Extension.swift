//
//  Decoder+Extension.swift
//  PoloniexTicker
//
//  Created by ViXette on 09/08/2019.
//  Copyright © 2019 ViXette. All rights reserved.
//

import Foundation

extension Decoder {
    func currentTitle() throws -> String {
        guard let titleKey = codingPath.last as? TitleKey else {
            throw DecodingError.dataCorrupted(.init(codingPath: codingPath, debugDescription: "Not in titled container"))
        }
        return titleKey.stringValue
    }

    func decodeTitledElements<Element: Decodable>(_ type: Element.Type) throws -> [Element] {
        let titles = try container(keyedBy: TitleKey.self)
        return try titles.allKeys.map { title in
            return try titles.decode(Element.self, forKey: title)
        }
    }
}

struct TitleKey: CodingKey {
    let stringValue: String
    init?(stringValue: String) { self.stringValue = stringValue }
    var intValue: Int? { return nil }
    init?(intValue: Int) { return nil }
}