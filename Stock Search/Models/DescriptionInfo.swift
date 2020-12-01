//
//  DescriptionInfo.swift
//  Stock Search
//
//  Created by 陈冲 on 11/28/20.
//

import Foundation
import SwiftyJSON
import Alamofire

class DescriptionInfoData: JSONable {
    var ticker: String
    var name: String
    var description: String
    
    required init(parameter: JSON) {
        ticker = parameter["ticker"].stringValue
        name = parameter["name"].stringValue
        description = parameter["description"].stringValue
    }
}

class DescriptionInfo: ObservableObject {
    @Published var ticker: String
    @Published var name: String
    @Published var description: String
    
    required init(ticker: String) {
        self.ticker = ticker
        self.name = ""
        self.description = ""
        let url: String = backendServerUrl + "/get-company-description/" + ticker
        if let url = URL(string: (url)) {
            print("requesting: \(url)")
            AF.request(url).validate().responseJSON { (response) in
                if let data = response.data {
                    let json = JSON(data)
                    if let jsonData = json.to(type: DescriptionInfoData.self) {
                        let descriptionInfoData = jsonData as! DescriptionInfoData
                        self.name = descriptionInfoData.name
                        self.description = descriptionInfoData.description
                    }//pass value
                }//parse response
            }//AF request
        }//pass url
    }//init
}//class
