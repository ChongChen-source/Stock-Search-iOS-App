//
//  StatsInfo.swift
//  Stock Search
//
//  Created by 陈冲 on 11/28/20.
//

import Foundation

struct StatsInfo: Hashable, Codable {
    var ticker: String
    var currPrice: Double
    var openPrice: Double
    var high: Double
    var low: Double
    var mid: Double
    var volume: Double
    var bidPrice: Double
}

func getStatsInfo(ticker: String) -> StatsInfo {
    // Call API
    let fetchedData: LatestPriceAPI = testLatestPriceData
    let info: StatsInfo = StatsInfo(ticker: ticker,
                                    currPrice: fetchedData.last,
                                    openPrice: fetchedData.open,
                                    high: fetchedData.high,
                                    low: fetchedData.low,
                                    mid: fetchedData.mid,
                                    volume: fetchedData.volume,
                                    bidPrice: fetchedData.bidPrice)
    return info
}
