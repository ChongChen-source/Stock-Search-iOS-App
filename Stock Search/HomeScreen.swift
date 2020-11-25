//
//  HomeScreen.swift
//  Stock Search
//
//  Created by 陈冲 on 11/23/20.
//

import SwiftUI

struct HomeScreen: View {
    @State var date = Date()
    
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    var body: some View {
        
        NavigationView {
            List {
                Text("\(dateString(date: date))").font(.title2).fontWeight(.heavy).foregroundColor(Color.gray).onAppear(perform: {let _ = self.updateTimer})
                
                Section(header: Text("PORTFOLIO")) {
                    VStack(alignment: .leading) {
                        Text("Net Worth")
                            .font(.title2)
                        Text("2000.00")
                            .font(.title2)
                            .fontWeight(.heavy)
                    }
                    NavigationLink(destination: StockDetails()) {
                        StockRow()
                    }
                    NavigationLink(destination: StockDetails()) {
                        StockRow()
                    }
                }
                Section(header: Text("FAVORITES")) {
                    NavigationLink(destination: StockDetails()) {
                        StockRow()
                    }
                    NavigationLink(destination: StockDetails()) {
                        StockRow()
                    }
                }
            }
            .navigationBarTitle(Text("Stocks"))
            .add(self.searchBar)
        }
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
    
    func dateString(date: Date) -> String {
         let time = dateFormat.string(from: date)
         return time
    }
    
    var updateTimer: Timer {
         Timer.scheduledTimer(withTimeInterval: 1, repeats: true,
                              block: {_ in
                                 self.date = Date()
                               })
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
