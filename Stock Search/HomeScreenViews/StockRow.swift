//
//  StockRowCell.swift
//  Stock Search
//
//  Created by 陈冲 on 11/27/20.
//

import SwiftUI

struct StockRow: View {
    @EnvironmentObject var localLists: LocalListsInfo
    @ObservedObject var prices: LocalPrices
    var stock: BasicStockInfo
    let timer = Timer.publish(every: 15, on: .main, in: .common).autoconnect()
    
    var body: some View {
        var latestPriceInfo: LatestPriceInfo = prices.getPrice(ticker: stock.ticker)
        NavigationLink(destination: StockDetails(ticker: stock.ticker,
                                                 descriptionInfo: DescriptionInfo(ticker: stock.ticker),
                                                 latestPriceInfo: latestPriceInfo,
                                                 newsInfo: NewsInfo(isTest: true),
                                                 isFavorited: stock.isFavorited)) {
            HStack {
                BasicStockInfoCell(stock: stock)
                Spacer()
                BasicPriceInfoCell(latestPriceInfo: latestPriceInfo)
            }
            .onReceive(timer) { time in
                print("Refresh price every 15s: \(time)")
                latestPriceInfo = LatestPriceInfo(preInfo: latestPriceInfo)
                localLists.netWorth = localLists.availableWorth + getSharesWorth()
                setNetWorth(worth: localLists.netWorth)
            }
        }
    }
}

//struct StockRowCell_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            StockRow(stock: testStocks[0])
//            StockRow(stock: testStocks[1])
//            StockRow(stock: testStocks[2])
//        }
//        .previewLayout(.fixed(width: 400, height: 80))
//    }
//}

struct BasicStockInfoCell: View {
    var stock: BasicStockInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(stock.ticker)
                .font(.title3)
                .fontWeight(.heavy)
            if !stock.isBought {
                Text(stock.name)
                    .foregroundColor(Color.gray)
            } else {
                Text("\(stock.sharesBought, specifier: "%.2f") shares")
                    .foregroundColor(Color.gray)
            }
        }
    }
}

struct BasicPriceInfoCell: View {
    @ObservedObject var latestPriceInfo: LatestPriceInfo
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text("\(latestPriceInfo.currPrice, specifier: "%.2f")")
                .fontWeight(.bold)
            
            HStack {
                if latestPriceInfo.change > 0 {
                    Image(systemName: "arrow.up.forward")
                }
                else if latestPriceInfo.change < 0 {
                    Image(systemName: "arrow.down.forward")
                }
                
                Text("\(latestPriceInfo.change, specifier: "%.2f")")
            }
            .foregroundColor(getColor())
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
