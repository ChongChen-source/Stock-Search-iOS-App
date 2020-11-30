//
//  StockDetails.swift
//  Stock Search
//
//  Created by 陈冲 on 11/23/20.
//

import SwiftUI

struct StockDetails: View {
    @EnvironmentObject var localLists: BasicStockInfoList
    @ObservedObject var detailsData: DetailsSumData
    @State var showToast: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                DetailsHeadCell(basicPriceInfo: detailsData.basicPriceInfo, descriptionInfo: detailsData.descriptionInfo)
                DetailsPortfolioCell(stock: detailsData.basicStockInfo, basicPriceInfo: detailsData.basicPriceInfo)
                DetailsStatsCell(statsInfo: detailsData.statsInfo)
                DetailsAboutCell(descriptionInfo: detailsData.descriptionInfo)
            }
            .padding(.horizontal)
            .navigationBarTitle(Text(detailsData.ticker))
            .toast(isPresented: self.$showToast) {
                Text(detailsData.basicStockInfo.isFavorited ? "Adding \(detailsData.ticker) to Favorites" : "Removing \(detailsData.ticker) from Favorites")
            }
        }
        .toolbar {
            Button(action: withAnimation{{
                // toggle the flag
                detailsData.basicStockInfo.isFavorited.toggle()
                // get local list
                var favoritesList: [BasicStockInfo] = getLocalStocks(listName: listNameFavorites)
                
                // case 1: add to the favorites list
                if detailsData.basicStockInfo.isFavorited {
                    favoritesList.append(detailsData.basicStockInfo)
                }
                // case 2: remove from the favorites list
                else if !favoritesList.isEmpty {
                    var indexes: [Int] = []
                    for (index, localStock) in favoritesList.enumerated() {
                        if (localStock.ticker == detailsData.basicStockInfo.ticker) {
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
                Image(systemName: detailsData.basicStockInfo.isFavorited ? "plus.circle.fill" : "plus.circle")
            }
        }
    }
}


struct StockDetails_Previews: PreviewProvider {
    static var previews: some View {
        StockDetails(detailsData: DetailsSumData(ticker: "AAPL"))
    }
}
