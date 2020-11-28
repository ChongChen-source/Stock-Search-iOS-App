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
    
    init(portfolioStocks: [BasicStockInfo] = [], favoritesStocks: [BasicStockInfo] = []) {
        self.portfolioStocks = portfolioStocks
        self.favoritesStocks = favoritesStocks
    }
}


