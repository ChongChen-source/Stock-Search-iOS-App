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
        var articles = getTestArticles()
        VStack(alignment: .leading) {
            Text("News")
                .font(.title2)
                .padding(.vertical)
            if !articles.isEmpty {
                DetailsNewsArticleCell(article: articles.remove(at: 0))
            }
            Divider()
            ForEach(articles) { article in
                DetailsNewsArticleCell(article: article)
            }
        }
    }
}

struct DetailsNewsSection_Previews: PreviewProvider {
    static var previews: some View {
        DetailsNewsSection(newsInfo: NewsInfo(isTest: true))
    }
}
