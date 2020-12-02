//
//  DetailsNewsArticleCell.swift
//  Stock Search
//
//  Created by 陈冲 on 12/1/20.
//

import SwiftUI
import KingfisherSwiftUI

struct DetailsNewsArticleCell: View {
    @Environment(\.openURL) var openURL
    @ObservedObject var article: ArticleData
    var body: some View {
        Button(action: {
            openURL(URL(string: article.url)!)
        }) {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Group {
                            Text(article.source)
                            Text(getTimeAgoStr())
                        }
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                    }
                    Text(article.title)
                    
                }
                Spacer()
                KFImage(URL(string: article.urlToImage)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(10)
            }
        }
        .foregroundColor(Color.black)
        .contextMenu {
            Button(action: {
                openURL(URL(string: article.url)!)
            }) {
                Label("Open in Safari", systemImage: "safari")
            }
            Button(action: {
                var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "twitter.com"
                urlComponents.path = "/intent/tweet"
                urlComponents.queryItems = [
                    URLQueryItem(name: "text", value: "Check out this link:"),
                    URLQueryItem(name: "hashtags", value: "CSCI571StockApp"),
                    URLQueryItem(name: "url", value: article.url),
                ]
                openURL(urlComponents.url!)
            }) {
                Label("Share on Twitter", systemImage: "square.and.arrow.up")
            }
        }//contenxtMenu
    }//body
    
    func getTimeAgoStr() -> String {
        //let publishedAt: String = article.publishedAt
        return "XXX days ago"
    }
}//struct

struct DetailsNewsArticleCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DetailsNewsArticleCell(article: testArticle)
            DetailsNewsArticleCell(article: testArticle)
            DetailsNewsArticleCell(article: testArticle)
            DetailsNewsArticleCell(article: testArticle)
        }
    }
}
