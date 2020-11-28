//
//  Data.swift
//  Stock Search
//
//  Created by 陈冲 on 11/26/20.
//
import UIKit
import SwiftUI
import Foundation

//var portfolioStocks: [BasicStockInfo] = userDefaults.object(forKey: "portfolioStocks") as? [BasicStockInfo] ??

let backendServerUrl: String = "http://csci571-hw8-web-app.us-east-1.elasticbeanstalk.com"

let listNamePortfolio: String = "portfolioList"
let listNameFavorites: String = "favoritesList"

let testStocks: [BasicStockInfo] = [
    BasicStockInfo(ticker: "AAPL", name: "Apple", isBought: false, sharesBought: 0, isFavorited: true),
    BasicStockInfo(ticker: "AMZN", name: "Amazon", isBought: true, sharesBought: 10.25687, isFavorited: false),
    BasicStockInfo(ticker: "TSLA", name: "Tesla", isBought: false, sharesBought: 0, isFavorited: false)
]

let testCompanyDescriptionData: CompanyDescriptionAPI = load("testCompanyDescriptionData.json")
let testLatestPriceData:  LatestPriceAPI = load("testLatestPriceData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
