//
//  DetailsNewsArticleCell.swift
//  Stock Search
//
//  Created by 陈冲 on 12/1/20.
//

import SwiftUI

struct DetailsNewsArticleCell: View {
    @Environment(\.openURL) var openURL
    @ObservedObject var article: ArticleData
    var body: some View {
        Button(action: {
            openURL(URL(string: article.url)!)
        }) {
            HStack {
                VStack {
                    HStack {
                        Text(article.source)
                    }
                    Text(article.title)
                }
                //Image
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
            
            
        }
    }//body
}//struct

struct DetailsNewsArticleCell_Previews: PreviewProvider {
    static var previews: some View {
        DetailsNewsArticleCell(article: testArticle)
    }
}
