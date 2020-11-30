//
//  latestPriceData.swift
//  Stock Search
//
//  Created by 陈冲 on 11/28/20.
//

import Foundation
import SwiftyJSON
import Alamofire

struct BasicPriceInfo: Hashable, Codable {
    var ticker: String
    var currPrice: Double
    var change: Double
}

struct StatsInfo: Hashable, Codable {
    var ticker: String
    var currPrice: Double
    var openPrice: Double
    var high: Double
    var low: Double
    var mid: Double
    var volume: Double
    var bidPrice: Double
}

class LatestPriceData: JSONable{
    @Published var ticker: String
    @Published var last: Double
    @Published var prevClose: Double
    @Published var open: Double
    @Published var high: Double
    @Published var low: Double
    @Published var mid: Double
    @Published var volume: Double
    @Published var bidPrice: Double
    
    required init(parameter: JSON) {
        self.ticker = parameter["ticker"].stringValue
        self.last = parameter["last"].doubleValue
        self.prevClose = parameter["prevClose"].doubleValue
        self.open = parameter["open"].doubleValue
        self.high = parameter["high"].doubleValue
        self.low = parameter["low"].doubleValue
        self.mid = parameter["mid"].doubleValue
        self.volume = parameter["volume"].doubleValue
        self.bidPrice = parameter["bidPrice"].doubleValue
    }
}

class LatestPriceInfo: ObservableObject {
    @Published var basicPriceInfo: BasicPriceInfo
    @Published var statsInfo: StatsInfo
    
    required init(ticker: String) {
        self.basicPriceInfo = BasicPriceInfo(ticker: "", currPrice: 0, change: 0)
        self.statsInfo = StatsInfo(ticker: "", currPrice: 0, openPrice: 0, high: 0, low: 0, mid: 0, volume: 0, bidPrice: 0)
        let url: String = backendServerUrl + "/get-latest-price/" + ticker
        if let url = URL(string: (url)) {
            print("requesting: \(url)")
            AF.request(url).validate().responseJSON { (response) in
                if let data = response.data {
                    let json = JSON(data)
                    if let jsonData = json.to(type: [LatestPriceData].self) {
                        let infoData = jsonData as! [LatestPriceData]
                        print("\(infoData[0])")
                        let info = infoData[0]
                        self.basicPriceInfo.ticker = info.ticker
                        self.basicPriceInfo.currPrice = info.last
                        let c: String = String(format: "%.2f", info.last)
                        print("Latest price of \(info.ticker) is: \(c)")
                        self.basicPriceInfo.change = info.last - info.prevClose
                        
                        self.statsInfo.ticker = info.ticker
                        self.statsInfo.currPrice = info.last
                        self.statsInfo.openPrice = info.open
                        self.statsInfo.high = info.high
                        self.statsInfo.low = info.low
                        self.statsInfo.mid = info.mid
                        self.statsInfo.volume = info.volume
                        self.statsInfo.bidPrice = info.bidPrice
                    }
                }
            }
        }
    }
}
