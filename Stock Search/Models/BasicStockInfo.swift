//
//  LocalStockInfo.swift
//  Stock Search
//
//  Created by 陈冲 on 11/25/20.
//

import Foundation

struct BasicStockInfo: Hashable, Codable, Identifiable {
    var id = UUID()
    var ticker: String
    var name: String
    var isBought: Bool
    var sharesBought: Double
    var isFavorited: Bool
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

func getBasicStockInfo(ticker: String) -> BasicStockInfo {
    let stock: BasicStockInfo = BasicStockInfo(ticker: ticker,
                                               name: DescriptionInfo(ticker: ticker).name,
                                               isBought: isBought(ticker: ticker),
                                               sharesBought: getSharesBought(ticker: ticker),
                                               isFavorited: isFavorited(ticker: ticker))
    return stock
}

func isBought(ticker: String) -> Bool {
    let portfolioList: [BasicStockInfo] = getLocalStocks(listName: listNamePortfolio)
    for stock in portfolioList {
        if ticker == stock.ticker && stock.sharesBought > 0{
            return true
        }
    }
    return false
}

func getSharesBought(ticker: String) -> Double {
    let portfolioList: [BasicStockInfo] = getLocalStocks(listName: listNamePortfolio)
    for stock in portfolioList {
        if ticker == stock.ticker {
            return stock.sharesBought
        }
    }
    return 0
}

func isFavorited(ticker: String) -> Bool {
    let favoritesList: [BasicStockInfo] = getLocalStocks(listName: listNameFavorites)
    for stock in favoritesList {
        if ticker == stock.ticker {
            return true
        }
    }
    return false
}
