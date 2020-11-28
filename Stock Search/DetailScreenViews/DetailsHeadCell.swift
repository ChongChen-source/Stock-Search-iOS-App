//
//  DetailsHeadCell.swift
//  Stock Search
//
//  Created by 陈冲 on 11/28/20.
//

import SwiftUI

struct DetailsHeadCell: View {
    @State var latestPriceInfo: LatestPriceInfo
    @State var descriptionInfo: DescriptionInfo
    var body: some View {
        VStack(alignment: .leading) {
            Text(descriptionInfo.name)
                .foregroundColor(Color.gray)
            HStack {
                Text("$ \(latestPriceInfo.lastPrice, specifier: "%.2f")")
                    .font(.title)
                    .fontWeight(.bold)
                Text("($ \(latestPriceInfo.change, specifier: "%.2f"))")
                    .foregroundColor(getColor())
            }
        }
    }
    
    func getColor() -> Color {
        if latestPriceInfo.change > 0 {
            return Color.green
        }
        else if latestPriceInfo.change < 0 {
            return Color.red
        }
        else {
            return Color.gray
        }
    }
}

struct DetailsHeadCell_Previews: PreviewProvider {
    static var previews: some View {
        let ticker = "AAPL"
        Group {
            DetailsHeadCell(latestPriceInfo: getLatestPriceInfo(ticker: ticker), descriptionInfo: getDescriptionInfo(ticker: ticker))
        }
        .previewLayout(.fixed(width: 400, height: 200))
    }
}
