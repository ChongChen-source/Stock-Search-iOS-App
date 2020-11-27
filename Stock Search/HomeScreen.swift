//
//  HomeScreen.swift
//  Stock Search
//
//  Created by 陈冲 on 11/23/20.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    @ObservedObject private var portfolioList = BasicStockInfoList(localStocks: testPortfolioStockArray)
    @ObservedObject private var favouritesList = BasicStockInfoList(localStocks: testPortfolioStockArray)
    
    @AppStorage("netWorth") var netWorth: Double = 2000
    
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
//                    .onDelete(perform: deletePortfolioStocks)
                }
                
                Section(header: Text("FAVORITES")) {
                    ForEach(favouritesList.localStocks) { stock in
                        NavigationLink(destination: StockDetails(ticker: stock.ticker)) {
                            StockRow(stock: stock)
                        }
                    }
                    .onMove(perform: moveFavouritesStocks)
                    .onDelete(perform: deleteFavouritesStocks)
                }
                
                TiingoLinkCell()
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
        }
    }

//    func deletePortfolioStocks(offsets: IndexSet) {
//        withAnimation {
//            portfolioList.localStocks.remove(atOffsets: offsets)
//        }
//    }
    
    func moveFavouritesStocks(from: IndexSet, to: Int) {
        withAnimation {
            favouritesList.localStocks.move(fromOffsets: from, toOffset: to)
        }
    }

    func deleteFavouritesStocks(offsets: IndexSet) {
        withAnimation {
            favouritesList.localStocks.remove(atOffsets: offsets)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
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
