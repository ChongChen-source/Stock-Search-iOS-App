//
//  DetailsHeadCell.swift
//  Stock Search
//
//  Created by 陈冲 on 11/28/20.
//

import SwiftUI

struct DetailsHeadCell: View {
    @ObservedObject var descriptionInfo: DescriptionInfo
    @ObservedObject var latestPriceInfo: LatestPriceInfo
    var body: some View {
        VStack {
            HStack {
                Text(descriptionInfo.name)
                    .foregroundColor(Color.gray)
                Spacer()
            }
            HStack(alignment: .bottom) {
                Text("$\(latestPriceInfo.currPrice, specifier: "%.2f")")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                Text("($\(latestPriceInfo.change, specifier: "%.2f"))")
                    .font(.title)
                    .foregroundColor(getColor())
                Spacer()
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
            DetailsHeadCell(descriptionInfo: DescriptionInfo(ticker: ticker),
                            latestPriceInfo: LatestPriceInfo(ticker: ticker))
        }
        .previewLayout(.fixed(width: 400, height: 200))
    }
}
