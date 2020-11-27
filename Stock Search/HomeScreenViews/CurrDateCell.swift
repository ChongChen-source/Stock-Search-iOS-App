//
//  CurrDateCell.swift
//  Stock Search
//
//  Created by 陈冲 on 11/27/20.
//

import SwiftUI

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
//        formatter.dateFormat = "hh:mm:ss a" // Test live time
        return formatter
    }
    
    var updateTimer: Timer {
         Timer.scheduledTimer(withTimeInterval: 1, repeats: true,
                              block: {_ in
                                 self.date = Date()
                               })
    }
}

struct CurrDateCell_Previews: PreviewProvider {
    static var previews: some View {
        CurrDateCell()
            .previewLayout(.fixed(width: 400, height: 80))
    }
}
