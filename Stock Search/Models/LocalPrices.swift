//
//  LocalPrices.swift
//  Stock Search
//
//  Created by 陈冲 on 12/2/20.
//

import Foundation
import SwiftyJSON
import Alamofire

class LocalPrices: ObservableObject {
    @Published var prices: [LatestPriceInfo]
    @Published var count: Int = 100
    
    func getPrice(ticker: String) -> LatestPriceInfo {
        for price in self.prices {
            if price.ticker == ticker {
                return price
            }
        }
        return LatestPriceInfo(ticker: ticker)
    }
    
    init(listName: String) {
        let list = getLocalStocks(listName: listName)
        self.count = list.count
        self.prices = []
        for stock in list {
            let ticker = stock.ticker
            var latestPriceInfo: LatestPriceInfo = LatestPriceInfo()
            latestPriceInfo.ticker = ticker
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
                            latestPriceInfo.currPrice = info.currPrice
                            latestPriceInfo.change = info.change
                            latestPriceInfo.open = info.open
                            latestPriceInfo.high = info.high
                            latestPriceInfo.low = info.low
                            latestPriceInfo.mid = info.mid
                            latestPriceInfo.volume = info.volume
                            latestPriceInfo.bidPrice = info.bidPrice
                            latestPriceInfo.isFetched = true
                            self.prices.append(latestPriceInfo)
                            self.count -= 1
                        }//pass value
                    }//parse response
                }//AF request
            }//pass url
        }
    }
}
