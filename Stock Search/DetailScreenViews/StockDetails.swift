//
//  StockDetails.swift
//  Stock Search
//
//  Created by 陈冲 on 11/23/20.
//

import SwiftUI

struct StockDetails: View {
    @EnvironmentObject var localLists: BasicStockInfoList
    
    var ticker: String
    @State var isFavorited: Bool
    
    @State var showToast: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                DetailsHeadCell(basicPriceInfo: LatestPriceInfo(ticker: ticker).basicPriceInfo, descriptionInfo: DescriptionInfo(ticker: ticker))
                DetailsPortfolioCell(stock: getBasicStockInfo(ticker: ticker), basicPriceInfo: LatestPriceInfo(ticker: ticker).basicPriceInfo)
                DetailsStatsCell(statsInfo: LatestPriceInfo(ticker: ticker).statsInfo)
                DetailsAboutCell(descriptionInfo: DescriptionInfo(ticker: ticker))
            }
            .padding(.horizontal)
            .navigationBarTitle(Text(ticker))
            .toast(isPresented: self.$showToast) {
                Text(isFavorited ? "Adding \(ticker) to Favorites" : "Removing \(ticker) from Favorites")
            }
        }
        .toolbar {
            Button(action: withAnimation{{
                // toggle the flag
                isFavorited.toggle()
                // get local list
                var favoritesList: [BasicStockInfo] = getLocalStocks(listName: listNameFavorites)
                
                // case 1: add to the favorites list
                if isFavorited {
                    var stock = getBasicStockInfo(ticker: ticker)
                    stock.isFavorited = isFavorited
                    favoritesList.append(stock)
                }
                // case 2: remove from the favorites list
                else if !favoritesList.isEmpty {
                    var indexes: [Int] = []
                    for (index, localStock) in favoritesList.enumerated() {
                        if (localStock.ticker == ticker) {
                            indexes.append(index)
                        }
                    }
                    for index in indexes {
                        favoritesList[index].isFavorited = isFavorited
                        favoritesList.remove(at: index)
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
        }
    }
}


//struct StockDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        StockDetails(detailsData: DetailsSumData(ticker: "AAPL"))
//    }
//}
