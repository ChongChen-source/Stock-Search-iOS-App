//
//  LocalStockList.swift
//  Stock Search
//
//  Created by 陈冲 on 11/26/20.
//

import Foundation

class StockInfoList: ObservableObject {
    @Published var localStocks: [BasicStockInfo]
    
    init(localStocks: [BasicStockInfo] = []) {
        self.localStocks = localStocks
    }
}
