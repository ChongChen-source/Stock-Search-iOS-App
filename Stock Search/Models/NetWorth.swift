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

func setNetWorth(netWorth: Double) -> Void {
    UserDefaults.standard.set(netWorth, forKey: keyNameNetWorth)
}

func getNetWorth() -> Double {
    if UserDefaults.standard.valueExists(forKey: keyNameNetWorth) {
        return UserDefaults.standard.double(forKey: keyNameNetWorth)
    }
    setNetWorth(netWorth: initNetWorth)
    return initNetWorth
}

func setAvailableWorth(availableWorth: Double) -> Void {
    UserDefaults.standard.set(availableWorth, forKey: keyNameAvailableWorth)
}

func getAvailableWorth() -> Double {
    if UserDefaults.standard.valueExists(forKey: keyNameAvailableWorth) {
        return UserDefaults.standard.double(forKey: keyNameAvailableWorth)
    }
    let availableWorth: Double = getNetWorth() - getSharesWorth()
    setAvailableWorth(availableWorth: availableWorth)
    return availableWorth
}

func updateNetWorth() -> Void {
    let availableWorth: Double = getAvailableWorth()
    let sharesWorth: Double = getSharesWorth()
    setNetWorth(netWorth: availableWorth + sharesWorth)
}

func getSharesWorth() -> Double {
    var sharesWorth: Double = 0
    let portfolioStocks: [BasicStockInfo] = getLocalStocks(listName: listNamePortfolio)
    for stock in portfolioStocks {
        let latestPrice: Double = getLatestPriceInfo(ticker: stock.ticker).lastPrice
        sharesWorth += latestPrice * stock.sharesBought
    }
    return sharesWorth
}
