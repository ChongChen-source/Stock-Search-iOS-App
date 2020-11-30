//
//  DetailsSum.swift
//  Stock Search
//
//  Created by 陈冲 on 12/1/20.
//

import Foundation

class DetailsSumData: ObservableObject {
    @Published var ticker: String
    @Published var basicStockInfo: BasicStockInfo
    @Published var descriptionInfo: DescriptionInfo
    @Published var basicPriceInfo: BasicPriceInfo
    @Published var statsInfo: StatsInfo
    
    required init (ticker: String) {
        self.ticker = ticker
        self.basicStockInfo = getBasicStockInfo(ticker: ticker)
        self.descriptionInfo = DescriptionInfo(ticker: ticker)
        let latestPriceInfo = LatestPriceInfo(ticker: ticker)
        self.basicPriceInfo = latestPriceInfo.basicPriceInfo
        self.statsInfo = latestPriceInfo.statsInfo
    }
}
