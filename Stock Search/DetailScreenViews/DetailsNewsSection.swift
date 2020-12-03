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
                .fontWeight(.medium)
                .padding(.vertical)
            if !articles.isEmpty {
                DetailsNewsHeadArticle(article: articles.remove(at: 0))
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
        ScrollView(.vertical) {
            VStack {
                DetailsNewsSection(newsInfo: NewsInfo(isTest: true))
            }
            .padding(.horizontal)
        }
    }
}
