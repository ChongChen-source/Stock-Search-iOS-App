//
//  latestPriceData.swift
//  Stock Search
//
//  Created by 陈冲 on 11/28/20.
//

import Foundation
import SwiftyJSON
import Alamofire

class LatestPriceData: JSONable{
    var ticker: String
    var currPrice: Double
    var change: Double
    var open: Double
    var high: Double
    var low: Double
    var mid: Double
    var volume: Double
    var bidPrice: Double
    
    required init(parameter: JSON) {
        ticker = parameter["ticker"].stringValue
        currPrice = parameter["last"].doubleValue
        change = parameter["last"].doubleValue - parameter["prevClose"].doubleValue
        open = parameter["open"].doubleValue
        high = parameter["high"].doubleValue
        low = parameter["low"].doubleValue
        mid = parameter["mid"].doubleValue
        volume = parameter["volume"].doubleValue
        bidPrice = parameter["bidPrice"].doubleValue
    }
}

class LatestPriceInfo: ObservableObject {
    @Published var ticker: String
    @Published var currPrice: Double
    @Published var change: Double
    @Published var open: Double
    @Published var high: Double
    @Published var low: Double
    @Published var mid: Double
    @Published var volume: Double
    @Published var bidPrice: Double
    @Published var isFetched: Bool
    
    init() {
        self.ticker = ""
        self.currPrice = 0
        self.change = 0
        self.open = 0
        self.high = 0
        self.low = 0
        self.mid = 0
        self.volume = 0
        self.bidPrice = 0
        self.isFetched = false
    }
    
    init(preInfo: LatestPriceInfo) {
        let ticker: String = preInfo.ticker
        self.ticker = ticker
        self.currPrice = preInfo.currPrice
        self.change = preInfo.change
        self.open = preInfo.open
        self.high = preInfo.high
        self.low = preInfo.low
        self.mid = preInfo.mid
        self.volume = preInfo.volume
        self.bidPrice = preInfo.bidPrice
        self.isFetched = false
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
                        self.currPrice = info.currPrice
                        self.change = info.change
                        self.open = info.open
                        self.high = info.high
                        self.low = info.low
                        self.mid = info.mid
                        self.volume = info.volume
                        self.bidPrice = info.bidPrice
                        self.isFetched = true
                    }//pass value
                }//parse response
            }//AF request
        }//pass url
    }//init
    
    init(ticker: String) {
        self.ticker = ticker
        self.currPrice = 0
        self.change = 0
        self.open = 0
        self.high = 0
        self.low = 0
        self.mid = 0
        self.volume = 0
        self.bidPrice = 0
        self.isFetched = false
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
                        self.currPrice = info.currPrice
                        self.change = info.change
                        self.open = info.open
                        self.high = info.high
                        self.low = info.low
                        self.mid = info.mid
                        self.volume = info.volume
                        self.bidPrice = info.bidPrice
                        self.isFetched = true
                    }//pass value
                }//parse response
            }//AF request
        }//pass url
    }//init
}//class

//class BasicStockPriceInfo: Observable {
//    @Published var ticker: String
//    @Published var currPrice: Double
//    @Published var change: Double
//    @Published var isFetched: Bool
//
//    init(ticker: String) {
//        self.ticker = ticker
//        self.currPrice = 0
//        self.change = 0
//        self.isFetched = false
//        let list = getLocalStocks(listName: listName)
//        for stock in list {
//            let ticker: String = stock.ticker
//            let url: String = backendServerUrl + "/get-latest-price/" + ticker
//            if let url = URL(string: (url)) {
//                print("requesting: \(url)")
//                AF.request(url).validate().responseJSON { (response) in
//                    if let data = response.data {
//                        let json = JSON(data)
//                        let infoArr:[JSON] = json.arrayValue
//                        let infoJson:JSON = infoArr[0]
//                        if let infoData = infoJson.to(type: LatestPriceData.self) {
//                            let info = infoData as! LatestPriceData
//                            self.currPrice = info.currPrice
//                            self.change = info.change
//                            self.isFetched = true
//                        }//pass value
//                    }//parse response
//                }//AF request
//            }//pass url
//        }
//    }
//}
