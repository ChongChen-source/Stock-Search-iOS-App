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
            LazyVStack {
                DetailsHeadCell(latestPriceInfo: getLatestPriceInfo(ticker: ticker), descriptionInfo: getDescriptionInfo(ticker: ticker))
                DetailsStatsCell(statsInfo: getStatsInfo(ticker: ticker))
                DetailsAboutCell(description: getDescriptionInfo(ticker: ticker).description)
                Spacer()
            }
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
        Button(action: {
            stock.isFavorited = !stock.isFavorited
            var favoritesList: [BasicStockInfo] = getLocalStocks(listName: listNameFavorites)
            if stock.isFavorited {
                favoritesList.append(stock)
                localLists.favoritesStocks = favoritesList
                setLocalStocks(localStocks: favoritesList, listName: listNameFavorites)
            } else {
                if favoritesList.isEmpty {
                    return
                }
                var index = 0
                for i in 0 ..< favoritesList.count {
                    if stock.ticker == favoritesList[i].ticker{
                        index = i
                        break
                    }
                }
                favoritesList.remove(at: index)
                localLists.favoritesStocks = favoritesList
                setLocalStocks(localStocks: favoritesList, listName: listNameFavorites)
            }
        }){
            Image(systemName: stock.isFavorited ? "plus.circle.fill" : "plus.circle")
        }
    }
}
