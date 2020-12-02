//
//  NewsInfo.swift
//  Stock Search
//
//  Created by 陈冲 on 12/1/20.
//

import Foundation
import SwiftyJSON
import Alamofire

class ArticleData: JSONable, Identifiable, ObservableObject {
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

let testArticleJson: JSON = load("testArticleData.json")
let testArticle: ArticleData = ArticleData(parameter: testArticleJson)


func getTestArticles() -> [ArticleData] {
    var articles: [ArticleData] = []
    let testNewsInfoJson: JSON = load("testArticles.json")
    let articleJsonArr: [JSON] = testNewsInfoJson["articles"].arrayValue
    for articleJson in articleJsonArr {
        if let articleData = articleJson.to(type: ArticleData.self) {
            let article = articleData as! ArticleData
            articles.append(article)
        }
    }
    return articles
}

class NewsInfo: ObservableObject {
    @Published var articles: [ArticleData]
    @Published var isFetched: Bool
    
    init(isTest: Bool) {
        self.articles = getTestArticles()
        self.isFetched = true
    }
    
    init(ticker: String) {
        self.articles = []
        self.isFetched = false
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
                            self.isFetched = true
                        }//pass value
                    }//loop JSON array
                }//parse response
            }//AF request
        }//pass url
    }//init
}//class
