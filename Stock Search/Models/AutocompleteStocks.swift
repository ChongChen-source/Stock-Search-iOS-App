//
//  AutocompleteAPI.swift
//  Stock Search
//
//  Created by 陈冲 on 11/30/20.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol JSONable {
    init?(parameter: JSON)
}

extension JSON {
    func to<T>(type: T?) -> Any? {
        if let baseObj = type as? JSONable.Type {
            if self.type == .array {
                var arrObject: [Any] = []
                for obj in self.arrayValue {
                    let object = baseObj.init(parameter: obj)
                    arrObject.append(object!)
                }
                return arrObject
            } else {
                let object = baseObj.init(parameter: self)
                return object!
            }
        }
        return nil
    }
}

struct AutocompleteAPI: Hashable, Codable {
    var ticker: String
    var name: String
}

class AutocompleteData: JSONable {
    var ticker: String
    var name: String
    
    required init(parameter: JSON) {
        ticker = parameter["ticker"].stringValue
        name = parameter["name"].stringValue
    }
}

class AutocompleteStocks: ObservableObject {
    @Published var stocks: [BasicStockInfo]
    var dataArr: [AutocompleteData]
    
    required init(input: String) {
        self.stocks = []
        self.dataArr = []
        let url: String = backendServerUrl + "/autocomplete/" + input
        if let url = URL(string: (url)) {
            print("requesting: \(url)")
            AF.request(url).validate().responseJSON { (response) in
                if let data = response.data {
                    let json = JSON(data)
                    if let jsonData = json.to(type: AutocompleteData.self) {
                        self.dataArr = jsonData as! [AutocompleteData]
                        for data in self.dataArr {
                            let stock = BasicStockInfo(ticker: data.ticker,
                                                       name: data.name,
                                                       isBought: isBought(ticker: data.ticker),
                                                       sharesBought: getSharesBought(ticker: data.ticker),
                                                       isFavorited: isFavorited(ticker: data.ticker))
                            self.stocks.append(stock)
                        }
                    }
                }
            }
        }
    }
}
