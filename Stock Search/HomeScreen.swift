//
//  HomeScreen.swift
//  Stock Search
//
//  Created by 陈冲 on 11/23/20.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    @EnvironmentObject var localLists: BasicStockInfoList
    
    @State var favoritesStocks: [BasicStockInfo] = testStocks
    
    @State var netWorth: Double = getNetWorth()
    
    var body: some View {
        NavigationView {
            List {
                if searchBar.text.isEmpty {
                    CurrDateCell()

                    Section(header: Text("PORTFOLIO")) {
                        NetWorthCell(netWorth: netWorth)
                        ForEach(localLists.portfolioStocks) { stock in
                            NavigationLink(destination: StockDetails(ticker: stock.ticker, isFavorited: stock.isFavorited)) {
                                StockRow(stock: stock)
                            }
                        }
                        .onMove(perform: movePortfolioStocks)
                    }

                    Section(header: Text("FAVORITES")) {
                        ForEach(localLists.favoritesStocks) { stock in
                            NavigationLink(destination: StockDetails(ticker: stock.ticker, isFavorited: stock.isFavorited)) {
                                StockRow(stock: stock)
                            }
                        }
                        .onMove(perform: moveFavoritesStocks)
                        .onDelete(perform: deleteFavoritesStocks)
                    }
                    TiingoLinkCell()
                } else {
                    if searchBar.text.count >= 3 {
                        SearchView(autocompleteStocks: AutocompleteStocks(input: searchBar.text))
                    }//length control
                }//if-else
            }//List
            .navigationBarTitle(Text("Stocks"))
            .add(self.searchBar)
            .toolbar {
                EditButton()
            }
        }
    }
    
    func movePortfolioStocks(from: IndexSet, to: Int) {
        withAnimation {
            localLists.portfolioStocks.move(fromOffsets: from, toOffset: to)
            setLocalStocks(localStocks: localLists.portfolioStocks, listName: listNamePortfolio)
        }
    }

    func moveFavoritesStocks(from: IndexSet, to: Int) {
        withAnimation {
            localLists.favoritesStocks.move(fromOffsets: from, toOffset: to)
            setLocalStocks(localStocks: localLists.favoritesStocks, listName: listNameFavorites)
        }
    }

    func deleteFavoritesStocks(offsets: IndexSet) {
        withAnimation {
            localLists.favoritesStocks.remove(atOffsets: offsets)
            setLocalStocks(localStocks: localLists.favoritesStocks, listName: listNameFavorites)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(BasicStockInfoList(portfolioStocks: getLocalStocks(listName: listNamePortfolio),
                                                  favoritesStocks: getLocalStocks(listName: listNameFavorites)))
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

struct SearchView: View {
    @ObservedObject var autocompleteStocks: AutocompleteStocks
    var body: some View {
        ForEach(autocompleteStocks.stocks) { stock in
            NavigationLink(destination: StockDetails(ticker: stock.ticker, isFavorited: stock.isFavorited)) {
                VStack(alignment: .leading) {
                    Text(stock.ticker)
                        .font(.title3)
                        .fontWeight(.heavy)
                    Text(stock.name)
                        .foregroundColor(Color.gray)
                }
            }
        }
    }
}
