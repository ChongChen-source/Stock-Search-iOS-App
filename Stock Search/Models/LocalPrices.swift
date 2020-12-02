//
//  LocalPrices.swift
//  Stock Search
//
//  Created by 陈冲 on 12/2/20.
//

import Foundation
import SwiftyJSON
import Alamofire

struct BasicPriceStruct {
    var ticker: String
    var currPrice: Double
    var change: Double
}

class LocalPrices: ObservableObject {
    @Published var prices: [BasicPriceStruct]
    @Published var count: Int = 100
    
    init(listName: String) {
        let list = getLocalStocks(listName: listName)
        self.count = list.count
        self.prices = []
        for stock in list {
            let ticker = stock.ticker
            var basicPriceInfo: BasicPriceStruct = BasicPriceStruct(ticker: ticker, currPrice: 0, change: 0)
            let url: String = backendServerUrl + "/get-latest-price/" + ticker
            if let url = URL(string: (url)) {
                print("requesting: \(url)")
                AF.request(url).validate().responseJSON { (response) in
                    if let data = response.data {
                        let json = JSON(data)
                        let infoArr:[JSON] = json.arrayValue
                        let infoJson:JSON = infoArr[0]
                        if let infoData = infoJson.to(type: LatestPriceData.self) {
                            let info = infoData as! LatestPriceData
                            basicPriceInfo.currPrice = info.currPrice
                            basicPriceInfo.change = info.change
                            self.prices.append(basicPriceInfo)
                            self.count -= 1
                        }//pass value
                    }//parse response
                }//AF request
            }//pass url
        }
    }
}
