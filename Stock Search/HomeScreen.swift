//
//  HomeScreen.swift
//  Stock Search
//
//  Created by 陈冲 on 11/23/20.
//

import SwiftUI

struct HomeScreen: View {
    @AppStorage("netWorth") var netWorth: Double = 2000
    
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    @ObservedObject var portfolioList: BasicStockInfoList
    
    @ObservedObject var favoritesList: BasicStockInfoList
    
    @State var favoritesStocks: [BasicStockInfo]
    
    @ObservedObject var testList: BasicStockInfoList = BasicStockInfoList(localStocks:testStocks)
    
    var body: some View {
        NavigationView {
            List {
                CurrDateCell()
                
                Section(header: Text("PORTFOLIO")) {
                    NetWorthCell(netWorth: netWorth)
                    ForEach(portfolioList.localStocks) { stock in
                        NavigationLink(destination: StockDetails(ticker: stock.ticker)) {
                            StockRow(stock: stock)
                        }
                    }
                    .onMove(perform: movePortfolioStocks)
                }
                
                Section(header: Text("FAVORITES")) {
                    ForEach(getLocalStocks(listName: listNameFavorites)) { stock in
                        NavigationLink(destination: StockDetails(ticker: stock.ticker)) {
                            StockRow(stock: stock)
                        }
                    }
                    .onMove(perform: moveFavoritesStocks)
                    .onDelete(perform: deleteFavoritesStocks)
                }
                TiingoLinkCell()
                
                Section(header: Text("ARRAY")) {
                    ForEach(favoritesStocks) { stock in
                        NavigationLink(destination: StockDetails(ticker: stock.ticker)) {
                            StockRow(stock: stock)
                        }
                    }
                    .onMove(perform: moveFavoritesStocks)
                    .onDelete(perform: deleteFavoritesStocks)
                }
                
                Section(header: Text("TESTS")) {
                    ForEach(testList.localStocks) { stock in
                        NavigationLink(destination: StockDetails(ticker: stock.ticker)) {
                            StockRow(stock: stock)
                        }
                    }
                    .onMove(perform: moveFavoritesStocks)
                    .onDelete(perform: deleteFavoritesStocks)
                }
            }
            .navigationBarTitle(Text("Stocks"))
            .add(self.searchBar)
            .toolbar {
                EditButton()
            }
        }
    }
    
    func movePortfolioStocks(from: IndexSet, to: Int) {
        withAnimation {
            portfolioList.localStocks.move(fromOffsets: from, toOffset: to)
            setLocalStocks(localStocks: portfolioList.localStocks, listName: listNamePortfolio)
        }
    }
    
    func moveFavoritesStocks(from: IndexSet, to: Int) {
        withAnimation {
            favoritesList.localStocks.move(fromOffsets: from, toOffset: to)
            setLocalStocks(localStocks: favoritesList.localStocks, listName: listNameFavorites)
        }
    }

    func deleteFavoritesStocks(offsets: IndexSet) {
        withAnimation {
            favoritesList.localStocks.remove(atOffsets: offsets)
            setLocalStocks(localStocks: favoritesList.localStocks, listName: listNameFavorites)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(portfolioList: BasicStockInfoList(localStocks: getLocalStocks(listName: listNamePortfolio)), favoritesList: BasicStockInfoList(localStocks: getLocalStocks(listName: listNameFavorites)), favoritesStocks: getLocalStocks(listName: listNameFavorites))
    }
}

struct NetWorthCell: View {
    @State var netWorth: Double
    var body: some View {
        VStack(alignment: .leading) {
            Text("Net Worth")
                .font(.title2)
            Text("\(netWorth, specifier: "%.2f")")
                .font(.title2)
                .fontWeight(.heavy)
        }
    }
}

struct TiingoLinkCell: View {
    var body: some View {
        HStack {
            Spacer()
            Link("Powered by Tiingo", destination: URL(string: "https://www.tiingo.com")!)
                .foregroundColor(Color.gray)
                .font(.footnote)
            Spacer()
        }
    }
}
