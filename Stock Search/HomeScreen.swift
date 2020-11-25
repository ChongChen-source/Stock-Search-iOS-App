//
//  HomeScreen.swift
//  Stock Search
//
//  Created by 陈冲 on 11/23/20.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var searchBar: SearchBar = SearchBar()
    @StateObject private var portfolioList = PortfolioList(localStocks: testPortfolioList)
    @StateObject private var favouritesList = FavouritesList(localStocks: testPortfolioList)
    
    var body: some View {
        NavigationView {
            List {
                CurrDateCell()
                
                Section(header: Text("PORTFOLIO")) {
                    NetWorthCell()
                    ForEach(portfolioList.localStocks) { stock in
                        StockRowCell(stock: stock)
                    }
                    .onMove(perform: moveStocks)
                    .onDelete(perform: deleteStocks)
                }
                
                Section(header: Text("FAVORITES")) {
                    ForEach(favouritesList.localStocks) { stock in
                        StockRowCell(stock: stock)
                    }
                    .onMove(perform: moveStocks)
                    .onDelete(perform: deleteStocks)
                }
            }
            .navigationBarTitle(Text("Stocks"))
            .add(self.searchBar)
            .toolbar {
                EditButton()
            }
        }
    }
    
    func moveStocks(from: IndexSet, to: Int) {
        withAnimation {
            portfolioList.localStocks.move(fromOffsets: from, toOffset: to)
        }
    }

    func deleteStocks(offsets: IndexSet) {
        withAnimation {
            portfolioList.localStocks.remove(atOffsets: offsets)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

struct StockRowCell: View {
    var stock: LocalStockInfo
    var body: some View {
        NavigationLink(destination: StockDetails()) {
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
