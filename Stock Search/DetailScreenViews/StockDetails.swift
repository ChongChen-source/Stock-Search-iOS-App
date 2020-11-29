//
//  StockDetails.swift
//  Stock Search
//
//  Created by 陈冲 on 11/23/20.
//

import SwiftUI

struct StockDetails: View {
    @EnvironmentObject var localLists: BasicStockInfoList
    @State var stock: BasicStockInfo
    @State var showToast: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                DetailsHeadCell(latestPriceInfo: getLatestPriceInfo(ticker: stock.ticker), descriptionInfo: getDescriptionInfo(ticker: stock.ticker))
                DetailsPortfolioCell(stock: stock)
                DetailsStatsCell(statsInfo: getStatsInfo(ticker: stock.ticker))
                DetailsAboutCell(description: getDescriptionInfo(ticker: stock.ticker).description)
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarTitle(Text(stock.ticker))
        .toolbar {
            Button(action: withAnimation{{
                // toggle the flag
                stock.isFavorited.toggle()
                // get local list
                var favoritesList: [BasicStockInfo] = getLocalStocks(listName: listNameFavorites)
                
                // case 1: add to the favorites list
                if stock.isFavorited {
                    favoritesList.append(stock)
                }
                // case 2: remove from the favorites list
                else if !favoritesList.isEmpty {
                    var indexes: [Int] = []
                    for (index, localStock) in favoritesList.enumerated() {
                        if (localStock.ticker == stock.ticker) {
                            indexes.append(index)
                        }
                    }
                    for index in indexes {
                        favoritesList.remove(at: index)
                    }
                }
                // update local storage
                localLists.favoritesStocks = favoritesList
                setLocalStocks(localStocks: favoritesList, listName: listNameFavorites)
                // show toast
                self.showToast = true
            }}){
                Image(systemName: stock.isFavorited ? "plus.circle.fill" : "plus.circle")
            }
        }
        .toast(isPresented: self.$showToast) {
            Text(stock.isFavorited ? "Adding \(stock.ticker) to Favorites" : "Removing \(stock.ticker) from Favorites")
        }
    }
}


struct StockDetails_Previews: PreviewProvider {
    static var previews: some View {
        StockDetails(stock: getBasicStockInfo(ticker: "AAPL"))
    }
}
