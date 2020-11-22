//
//  StockList.swift
//  Stock Search
//
//  Created by 陈冲 on 11/22/20.
//

import SwiftUI

struct StockList: View {
    @State var date = Date()
    
    var body: some View {
        NavigationView {

            List {
                Section(header: Text("PORTFOLIO")) {
                    StockRow()
                    StockRow()
                }
                Section(header: Text("FAVORITES")) {
                    StockRow()
                    StockRow()
                }
            }
            .navigationBarTitle(Text("\(dateString(date: date))")).onAppear(perform: {let _ = self.updateTimer})        }
    }
    
    var dateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
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

struct StockList_Previews: PreviewProvider {
    static var previews: some View {
        StockList()
    }
}
