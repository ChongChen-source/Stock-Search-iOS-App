//
//  NewsInfo.swift
//  Stock Search
//
//  Created by 陈冲 on 12/1/20.
//

import Foundation
import SwiftyJSON
import Alamofire

class ArticleData: JSONable, Identifiable {
    var id = UUID()
    var source: String
    var author: String
    var title: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    
    required init(parameter: JSON) {
        source = parameter["source"]["name"].stringValue
        author = parameter["author"].stringValue
        title = parameter["title"].stringValue
        url = parameter["url"].stringValue
        urlToImage = parameter["urlToImage"].stringValue
        publishedAt = parameter["publishedAt"].stringValue
    }
}

class NewsInfo: ObservableObject {
    @Published var articles: [ArticleData]
    
    required init(ticker: String) {
        self.articles = []
        let url: String = backendServerUrl + "/get-news/" + ticker
        if let url = URL(string: (url)) {
            print("requesting: \(url)")
            AF.request(url).validate().responseJSON { (response) in
                if let data = response.data {
                    let json = JSON(data)
                    let articleJsonArr = json["articles"].arrayValue
                    for articleJson in articleJsonArr {
                        if let articleData = articleJson.to(type: ArticleData.self) {
                            let article = articleData as! ArticleData
                            self.articles.append(article)
                        }//pass value
                    }//loop JSON array
                }//parse response
            }//AF request
        }//pass url
    }//init
}//class
