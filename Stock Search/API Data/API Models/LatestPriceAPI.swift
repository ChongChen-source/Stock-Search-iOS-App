//
//  latestPriceData.swift
//  Stock Search
//
//  Created by 陈冲 on 11/28/20.
//

import Foundation

struct LatestPriceAPI: Hashable, Codable {
    var timestamp: String
    var bidSize: Double
    var lastSaleTimestamp: String
    var low: Double
    var bidPrice: Double
    var prevClose: Double
    var quoteTimestamp: String
    var last: Double
    var askSize: Double
    var volume: Double
    var lastSize: Double
    var ticker: String
    var high: Double
    var mid: Double
    var askPrice: Double
    var open: Double
    var tngoLast: Double
}

let testLatestPriceData:  [LatestPriceAPI] = load("testLatestPriceData.json")
