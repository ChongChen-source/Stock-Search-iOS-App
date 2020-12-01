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
        VStack(alignment: .leading) {
            Text("News")
                .font(.title2)
                .padding(.vertical)
            ForEach(articles) { article in
                Text(article.title)
                Divider()
            }
        }
    }
}

struct DetailsNewsSection_Previews: PreviewProvider {
    static var previews: some View {
        DetailsNewsSection(newsInfo: NewsInfo(ticker: "AAPL"))
    }
}
