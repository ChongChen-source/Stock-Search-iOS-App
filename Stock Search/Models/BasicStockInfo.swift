//
//  LocalStockInfo.swift
//  Stock Search
//
//  Created by 陈冲 on 11/25/20.
//

import Foundation

struct BasicStockInfo: Hashable, Codable, Identifiable {
    var id: Int
    var ticker: String
    var name: String
}
