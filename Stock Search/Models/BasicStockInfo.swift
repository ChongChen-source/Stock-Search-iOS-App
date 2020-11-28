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
    var isFavourited: Bool
}

func getBasicStockInfo(ticker: String) -> BasicStockInfo {
    let stock: BasicStockInfo = BasicStockInfo(ticker: ticker,
                                               name: getDescriptionInfo(ticker: ticker).name,
                                               isBought: isBought(ticker: ticker),
                                               sharesBought: getSharesBought(ticker: ticker),
                                               isFavourited: isFavourited(ticker: ticker))
    return stock
}

func isBought(ticker: String) -> Bool {
    let portfolioList: [BasicStockInfo] = getLocalStocks(listName: "portfolioList")
    for stock in portfolioList {
        if ticker == stock.ticker {
            return true
        }
    }
    return false
}

func getSharesBought(ticker: String) -> Double {
    let portfolioList: [BasicStockInfo] = getLocalStocks(listName: "portfolioList")
    for stock in portfolioList {
        if ticker == stock.ticker {
            return stock.sharesBought
        }
    }
    return 0
}

func isFavourited(ticker: String) -> Bool {
    let favouritesList: [BasicStockInfo] = getLocalStocks(listName: "favouritesList")
    for stock in favouritesList {
        if ticker == stock.ticker {
            return true
        }
    }
    return false
}
