//
//  DetailsStatsCell.swift
//  Stock Search
//
//  Created by 陈冲 on 11/28/20.
//

import SwiftUI

struct DetailsStatsCell: View {
    @State var statsInfo: StatsInfo = getStatsInfo(ticker: "AAPL")

    let rows = [
        GridItem(.fixed(200)),
    ]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: .firstTextBaseline) {
                Text("Current Price: ")
                Text("Open Price: ")
                Text("High: ")
                Text("Low: ")
                Text("Mid: ")
                Text("Volume: ")
                Text("Bid Price: ")
            }
        }
    }
}

struct DetailsStatsCell_Previews: PreviewProvider {
    static var previews: some View {
        DetailsStatsCell()
    }
}
