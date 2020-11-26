//
//  LocalStockList.swift
//  Stock Search
//
//  Created by 陈冲 on 11/26/20.
//

import Foundation

class LocalStockList: ObservableObject {
    @Published var localStocks: [LocalStockInfo]
    
    init(localStocks: [LocalStockInfo] = []) {
        self.localStocks = localStocks
    }
}
