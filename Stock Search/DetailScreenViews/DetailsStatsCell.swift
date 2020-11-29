//
//  DetailsStatsCell.swift
//  Stock Search
//
//  Created by 陈冲 on 11/28/20.
//

import SwiftUI

struct DetailsStatsCell: View {
//    @State var fields: [String]
    @State var statsInfo: StatsInfo
    
    var thressColumnGrid:[GridItem] = [
        .init(.fixed(30), spacing: .none, alignment: .leading),
        .init(.fixed(30), spacing: .none, alignment: .leading),
        .init(.fixed(30), spacing: .none, alignment: .leading)
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Stats")
                .font(.title2)
            ScrollView(.horizontal) {
                LazyHGrid(rows: thressColumnGrid, spacing: 40) {
                    Text("Current Price: \(statsInfo.currPrice, specifier: "%.2f")")
                    Text("Open Price: \(statsInfo.openPrice, specifier: "%.2f")")
                    Text("High: \(statsInfo.high, specifier: "%.2f")")
                    Text("Low: \(statsInfo.low, specifier: "%.2f")")
                    Text("Mid: \(statsInfo.mid, specifier: "%.2f")")
                    Text("Volume: \(statsInfo.volume, specifier: "%.2f")")
                    Text("Bid Price: \(statsInfo.bidPrice, specifier: "%.2f")")
                }
            }
        }
    }
}

struct DetailsStatsCell_Previews: PreviewProvider {
    static var previews: some View {
        DetailsStatsCell(statsInfo: getStatsInfo(ticker: "AAPL"))
            .previewLayout(.fixed(width: 400, height: 200))
    }
}
