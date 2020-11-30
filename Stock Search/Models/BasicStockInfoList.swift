//
//  LocalStockList.swift
//  Stock Search
//
//  Created by 陈冲 on 11/26/20.
//

import Foundation

class BasicStockInfoList: ObservableObject {
    @Published var portfolioStocks: [BasicStockInfo]
    @Published var favoritesStocks: [BasicStockInfo]
    @Published var availableWorth: Double
    
    init(portfolioStocks: [BasicStockInfo] = [], favoritesStocks: [BasicStockInfo] = [], availableWorth: Double = 2000) {
        self.portfolioStocks = portfolioStocks
        self.favoritesStocks = favoritesStocks
        self.availableWorth = availableWorth
    }
}


