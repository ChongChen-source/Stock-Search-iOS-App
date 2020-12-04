//
//  StockDetails.swift
//  Stock Search
//
//  Created by 陈冲 on 11/23/20.
//

import SwiftUI

struct StockDetails: View {
    @EnvironmentObject var localLists: LocalListsInfo
    
    var ticker: String
    @ObservedObject var descriptionInfo: DescriptionInfo
    @ObservedObject var latestPriceInfo: LatestPriceInfo
    @ObservedObject var newsInfo: NewsInfo
    
    @State var isFavorited: Bool
    @State var showToast: Bool = false
    
    var body: some View {
        if !(descriptionInfo.isFetched && latestPriceInfo.isFetched && newsInfo.isFetched) {
            VStack {
                ProgressView("Fetching Data...")
            }
            .navigationBarTitle(Text(ticker))
        }
        
        else {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    DetailsHeadSection(descriptionInfo: descriptionInfo, latestPriceInfo: latestPriceInfo)
                    VStack {
                        HighChartsWebView(ticker: ticker)
                            .frame(height:330)
                    }
                    DetailsPortfolioSection(descriptionInfo: descriptionInfo, stock: getBasicStockInfo(ticker: ticker), latestPriceInfo: latestPriceInfo)
                    DetailsStatsSection(latestPriceInfo: latestPriceInfo)
                    DetailsAboutSection(descriptionInfo: descriptionInfo)
                    DetailsNewsSection(newsInfo: newsInfo)
                }
                .padding(.horizontal)
            }
            .navigationBarTitle(Text(ticker))
            .toast(isPresented: self.$showToast) {
                Text(isFavorited ? "Adding \(ticker) to Favorites" : "Removing \(ticker) from Favorites")
                    .foregroundColor(Color.white)
                    .padding(.vertical)
            }
            .toolbar {
                Button(action: withAnimation{{
                    // toggle the flag
                    isFavorited.toggle()
                    // get local list
                    var favoritesList: [BasicStockInfo] = getLocalStocks(listName: listNameFavorites)
                    
                    // case 1: add to the favorites list
                    if isFavorited && !Stock_Search.isFavorited(ticker: ticker){
                        let stock = BasicStockInfo(ticker: ticker,
                                                   name: descriptionInfo.name,
                                                   isBought: isBought(ticker: ticker),
                                                   sharesBought: getSharesBought(ticker: ticker),
                                                   isFavorited: true)
                        favoritesList.append(stock)
                    }
                    // case 2: remove from the favorites list
                    else if !favoritesList.isEmpty {
                        var removeIndex: Int = -1
                        for (index, localStock) in favoritesList.enumerated() {
                            if (localStock.ticker == ticker) {
                                favoritesList[index].isFavorited = false
                                removeIndex = index
                            }
                        }
                        if removeIndex != -1 {
                            favoritesList.remove(at: removeIndex)
                        }
                    }
                    // update local storage
                    localLists.favoritesStocks = favoritesList
                    setLocalStocks(localStocks: favoritesList, listName: listNameFavorites)
                    // show toast
                    self.showToast = true
                }}){
                    Image(systemName: isFavorited ? "plus.circle.fill" : "plus.circle")
                }
            }//toolbar
        }//if-else: ProgressView
    }//body
}//struct


struct StockDetails_Previews: PreviewProvider {
    static var ticker = "DETAIL"
    static var previews: some View {
        StockDetails(ticker: ticker,
                     descriptionInfo: DescriptionInfo(ticker: ticker),
                     latestPriceInfo: LatestPriceInfo(ticker: ticker),
                     newsInfo: NewsInfo(isTest: true),
                     isFavorited: true)
    }
}
