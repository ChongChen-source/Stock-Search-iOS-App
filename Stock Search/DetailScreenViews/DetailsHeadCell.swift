//
//  DetailsHeadCell.swift
//  Stock Search
//
//  Created by 陈冲 on 11/28/20.
//

import SwiftUI

struct DetailsHeadCell: View {
//    @State var basicPriceInfo: BasicPriceInfo
    @ObservedObject var descriptionInfo: DescriptionInfo
    var body: some View {
        VStack {
            HStack {
                Text(descriptionInfo.name)
                    .foregroundColor(Color.gray)
                Spacer()
            }
//            HStack {
//                Text("$ \(basicPriceInfo.currPrice, specifier: "%.2f")")
//                    .font(.title)
//                    .fontWeight(.bold)
//                Text("($ \(basicPriceInfo.change, specifier: "%.2f"))")
//                    .foregroundColor(getColor())
//                Spacer()
//            }
        }
    }
    
//    func getColor() -> Color {
//        if basicPriceInfo.change > 0 {
//            return Color.green
//        }
//        else if basicPriceInfo.change < 0 {
//            return Color.red
//        }
//        else {
//            return Color.gray
//        }
//    }
}

//struct DetailsHeadCell_Previews: PreviewProvider {
//    static var previews: some View {
//        let ticker = "AAPL"
//        Group {
//            DetailsHeadCell(basicPriceInfo: LatestPriceInfo(ticker: ticker).basicPriceInfo, descriptionInfo: DescriptionInfo(ticker: ticker))
//        }
//        .previewLayout(.fixed(width: 400, height: 200))
//    }
//}
