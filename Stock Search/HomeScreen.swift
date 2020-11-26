//
//  HomeScreen.swift
//  Stock Search
//
//  Created by 陈冲 on 11/23/20.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var searchBar: SearchBar = SearchBar()
    @StateObject private var portfolioList = BasicStockInfoList(localStocks: testPortfolioStockArray)
    @StateObject private var favouritesList = BasicStockInfoList(localStocks: testPortfolioStockArray)
    
    var body: some View {
        NavigationView {
            List {
                CurrDateCell()
                
                Section(header: Text("PORTFOLIO")) {
                    NetWorthCell()
                    ForEach(portfolioList.localStocks) { stock in
                        StockRowCell(stock: stock)
                    }
                    .onMove(perform: movePortfolioStocks)
                    .onDelete(perform: deletePortfolioStocks)
                }
                
                Section(header: Text("FAVORITES")) {
                    ForEach(favouritesList.localStocks) { stock in
                        StockRowCell(stock: stock)
                    }
                    .onMove(perform: moveFavouritesStocks)
                    .onDelete(perform: deleteFavouritesStocks)
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
        }
    }

    func deletePortfolioStocks(offsets: IndexSet) {
        withAnimation {
            portfolioList.localStocks.remove(atOffsets: offsets)
        }
    }
    
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

struct StockRowCell: View {
    var stock: BasicStockInfo
    var body: some View {
        NavigationLink(destination: StockDetails(ticker: stock.ticker)) {
            StockRow(stock: stock)
        }
    }
}

struct NetWorthCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Net Worth")
                .font(.title2)
            Text("2000.00")
                .font(.title2)
                .fontWeight(.heavy)
        }
    }
}

struct CurrDateCell: View {
    @State var date = Date()
    var body: some View {
        Text("\(dateString(date: date))").font(.title2).fontWeight(.heavy).foregroundColor(Color.gray).onAppear(perform: {let _ = self.updateTimer})
    }
    
    func dateString(date: Date) -> String {
         let time = dateFormat.string(from: date)
         return time
    }
    
    var dateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("MMMMd, yyyy")
//      formatter.dateFormat = "hh:mm:ss a" // Test live time
        return formatter
    }
    
    var updateTimer: Timer {
         Timer.scheduledTimer(withTimeInterval: 1, repeats: true,
                              block: {_ in
                                 self.date = Date()
                               })
    }
}
