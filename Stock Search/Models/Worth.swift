//
//  NetWorth.swift
//  Stock Search
//
//  Created by 陈冲 on 11/29/20.
//

import Foundation

extension UserDefaults {
    func valueExists(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }
}

let initNetWorth: Double = 2000

func setAvailableWorth(availableWorth: Double) -> Void {
    UserDefaults.standard.set(availableWorth, forKey: keyNameAvailableWorth)
}

func getAvailableWorth() -> Double {
    if UserDefaults.standard.valueExists(forKey: keyNameAvailableWorth) {
        return UserDefaults.standard.double(forKey: keyNameAvailableWorth)
    } else {
        setAvailableWorth(availableWorth: initNetWorth)
        return initNetWorth
    }
}

func getSharesWorth() -> Double {
    var sharesWorth: Double = 0
    let portfolioStocks: [BasicStockInfo] = getLocalStocks(listName: listNamePortfolio)
    for stock in portfolioStocks {
        let currPrice: Double = LatestPriceInfo(ticker: stock.ticker).currPrice
        sharesWorth += currPrice * stock.sharesBought
    }
    return sharesWorth
}

func getNetWorth() -> Double {
    if UserDefaults.standard.valueExists(forKey: keyNameNetWorth) {
        return UserDefaults.standard.double(forKey: keyNameNetWorth)
    } else {
        setNetWorth(worth: initNetWorth)
        return initNetWorth
    }
}

func setNetWorth(worth: Double) -> Void {
    UserDefaults.standard.set(worth, forKey: keyNameNetWorth)
}
