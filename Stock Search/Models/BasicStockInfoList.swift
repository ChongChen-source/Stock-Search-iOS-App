//
//  LocalStockList.swift
//  Stock Search
//
//  Created by 陈冲 on 11/26/20.
//

import Foundation

class BasicStockInfoList: ObservableObject {
    @Published var localStocks: [BasicStockInfo]
    
    init(localStocks: [BasicStockInfo] = []) {
        self.localStocks = localStocks
    }
}

func setLocalStocks(localStocks: [BasicStockInfo], listName: String) -> Void {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(localStocks) {
        UserDefaults.standard.set(encoded, forKey: listName)
    }
}

func getLocalStocks(listName: String) -> [BasicStockInfo] {
    if let localStocks = UserDefaults.standard.object(forKey: listName) as? Data {
        let decoder = JSONDecoder()
        if let loadedStocks = try? decoder.decode([BasicStockInfo].self, from: localStocks) {
            return loadedStocks
        }
    }
    return []
}
