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
    @ObservedObject var descriptionInfo: DescriptionInfo
    @ObservedObject var latestPriceInfo: LatestPriceInfo
    
    @State var isFavorited: Bool
    @State var showToast: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                DetailsHeadCell(descriptionInfo: descriptionInfo)
                DetailsPortfolioCell(stock: getBasicStockInfo(ticker: ticker), latestPriceInfo: latestPriceInfo)
                DetailsStatsCell(latestPriceInfo: latestPriceInfo)
                DetailsAboutCell(descriptionInfo: descriptionInfo)
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
        }
    }
}


//struct StockDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        StockDetails(detailsData: DetailsSumData(ticker: "AAPL"))
//    }
//}
