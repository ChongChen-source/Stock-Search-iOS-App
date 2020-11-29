//
//  StockDetails.swift
//  Stock Search
//
//  Created by 陈冲 on 11/23/20.
//

import SwiftUI

struct StockDetails: View {
    @EnvironmentObject var localLists: BasicStockInfoList
    @State var ticker: String
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                DetailsHeadCell(latestPriceInfo: getLatestPriceInfo(ticker: ticker), descriptionInfo: getDescriptionInfo(ticker: ticker))
                DetailsStatsCell(statsInfo: getStatsInfo(ticker: ticker))
                DetailsAboutCell(description: getDescriptionInfo(ticker: ticker).description)
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarTitle(Text(ticker))
        .toolbar {
            FavouritesButton(stock: getBasicStockInfo(ticker: ticker))
        }
    }
}

struct StockDetails_Previews: PreviewProvider {
    static var previews: some View {
        StockDetails(ticker: "AAPL")
    }
}

struct FavouritesButton: View {
    @EnvironmentObject var localLists: BasicStockInfoList
    @State var stock: BasicStockInfo
    var body: some View {
        Button(action: withAnimation{{
            // toggle the flag
            stock.isFavorited = !stock.isFavorited
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
        }}){
            Image(systemName: stock.isFavorited ? "plus.circle.fill" : "plus.circle")
        }
    }
}
