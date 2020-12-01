//
//  DetailsStatsCell.swift
//  Stock Search
//
//  Created by 陈冲 on 11/28/20.
//

import SwiftUI

struct DetailsStatsSection: View {
    @ObservedObject var latestPriceInfo: LatestPriceInfo
    
    var thressColumnGrid:[GridItem] = [
        .init(.fixed(30), spacing: .none, alignment: .leading),
        .init(.fixed(30), spacing: .none, alignment: .leading),
        .init(.fixed(30), spacing: .none, alignment: .leading)
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Stats")
                .font(.title2)
                .padding(.vertical)
            ScrollView(.horizontal) {
                LazyHGrid(rows: thressColumnGrid, spacing: 40) {
                    Text("Current Price: \(latestPriceInfo.currPrice, specifier: "%.2f")")
                    Text("Open Price: \(latestPriceInfo.open, specifier: "%.2f")")
                    Text("High: \(latestPriceInfo.high, specifier: "%.2f")")
                    Text("Low: \(latestPriceInfo.low, specifier: "%.2f")")
                    Text("Mid: \(latestPriceInfo.mid, specifier: "%.2f")")
                    Text("Volume: \(latestPriceInfo.volume, specifier: "%.2f")")
                    Text("Bid Price: \(latestPriceInfo.bidPrice, specifier: "%.2f")")
                }
                .padding(.vertical, 0)
            }
        }
    }
}

//struct DetailsStatsSection_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsStatsCell(statsInfo: LatestPriceInfo(ticker: "AAPL").statsInfo)
//            .previewLayout(.fixed(width: 400, height: 200))
//    }
//}
