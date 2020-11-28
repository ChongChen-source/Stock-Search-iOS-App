//
//  StockDetails.swift
//  Stock Search
//
//  Created by 陈冲 on 11/23/20.
//

import SwiftUI

struct StockDetails: View {
    @State var ticker: String
    
    var body: some View {
        NavigationView {
            DetailsHeadCell(latestPriceInfo: getLatestPriceInfo(ticker: ticker), descriptionInfo: getDescriptionInfo(ticker: ticker))
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
    @State var stock: BasicStockInfo
    var body: some View {
        Button(action: {
            stock.isFavourited = !stock.isFavourited
            var favouritesList: [BasicStockInfo] = getLocalStocks(listName: "favouritesList")
            if stock.isFavourited {
                favouritesList.append(stock)
                setLocalStocks(localStocks: favouritesList, listName: "favouritesList")
            } else {
                if favouritesList.isEmpty {
                    return
                }
                var index = 0
                for i in 0 ..< favouritesList.count {
                    if stock.ticker == favouritesList[i].ticker{
                        index = i
                        break
                    }
                }
                favouritesList.remove(at: index)
                setLocalStocks(localStocks: favouritesList, listName: "favouritesList")
            }
        }){
            Image(systemName: stock.isFavourited ? "plus.circle.fill" : "plus.circle")
        }
    }
}
