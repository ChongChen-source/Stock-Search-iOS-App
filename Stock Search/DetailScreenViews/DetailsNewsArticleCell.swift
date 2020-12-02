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
        NewsArticleFollowing(article: article)
        .frame(width: .infinity, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
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
        }//contextMenu
    }//body
    

}//struct

struct DetailsNewsArticleCell_Previews: PreviewProvider {
    static let articles = getTestArticles()
    static var previews: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(articles) { article in
                    DetailsNewsArticleCell(article: article)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct NewsArticleFollowing: View {
    @ObservedObject var article: ArticleData
    @Environment(\.openURL) var openURL
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.white)
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Group {
                            Text(article.source)
                            Text(getTimeAgoStr(preDateStr: article.publishedAt))
                        }
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                    }
                    Text(article.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                KFImage(URL(string: article.urlToImage)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .contentShape(RoundedRectangle(cornerRadius: 10))
                    .clipped()
                    .cornerRadius(10)
            }//HStack
            .frame(width: .infinity, height: 100, alignment: .leading)
            .cornerRadius(10)
        }//ZStack
        .cornerRadius(10)
    }//body
}
