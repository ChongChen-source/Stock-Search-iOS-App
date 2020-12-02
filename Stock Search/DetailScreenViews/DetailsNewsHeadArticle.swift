//
//  DetailsNewsHeadArticle.swift
//  Stock Search
//
//  Created by 陈冲 on 12/2/20.
//

import SwiftUI
import KingfisherSwiftUI

struct DetailsNewsHeadArticle: View {
    @Environment(\.openURL) var openURL
    @ObservedObject var article: ArticleData
    var body: some View {
        NewsArticleHead(article: article)
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

struct DetailsNewsHeadArticle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DetailsNewsHeadArticle(article: testArticle)
        }
        .padding(.horizontal)
    }
}

struct NewsArticleHead: View {
    @ObservedObject var article: ArticleData
    @Environment(\.openURL) var openURL
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.white)
            VStack(alignment: .leading) {
                KFImage(URL(string: article.urlToImage)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 200, alignment: .center)
                    .contentShape(RoundedRectangle(cornerRadius: 10))
                    .clipped()
                    .cornerRadius(10)
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
                .frame(width: .infinity, height: 80)
            }//VStack
            .cornerRadius(10)
        }//ZStack
        .cornerRadius(10)
    }//body
}
