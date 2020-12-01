//
//  DetailsNewsCell.swift
//  Stock Search
//
//  Created by 陈冲 on 11/29/20.
//

import SwiftUI

struct DetailsNewsSection: View {
    @ObservedObject var newsInfo: NewsInfo
    var body: some View {
        let articles = newsInfo.articles
        List {
            ForEach(articles) { article in
                Text(article.title)
                Text(article.source)
                Text(article.url)
                Text(article.urlToImage)
                Text(article.publishedAt)
            }
        }
    }
}

struct DetailsNewsSection_Previews: PreviewProvider {
    static var previews: some View {
        DetailsNewsSection(newsInfo: NewsInfo(ticker: "AAPL"))
    }
}
