//
//  StockRowCell.swift
//  Stock Search
//
//  Created by 陈冲 on 11/27/20.
//

import SwiftUI

struct StockRow: View {
    var stock: BasicStockInfo
    
    var body: some View {
        HStack {
            BasicStockInfoCell(stock: stock)
            Spacer()
            LatestPriceInfoCell(lastestPriceInfo: getLatestPriceInfo())
        }
    }
    
    func getLatestPriceInfo() -> LatestPriceInfo {
        for info in testLatestPrices {
            if stock.ticker == info.ticker {
                return info
            }
        }
        return LatestPriceInfo(ticker: "Unfound", lastPrice: 0, change: 0)
    }}

struct StockRowCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StockRow(stock: testStocks[0])
            StockRow(stock: testStocks[1])
            StockRow(stock: testStocks[2])
        }
        .previewLayout(.fixed(width: 400, height: 80))
    }
}

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

struct LatestPriceInfoCell: View {
    @State var lastestPriceInfo: LatestPriceInfo
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text("\(lastestPriceInfo.lastPrice, specifier: "%.2f")")
                .fontWeight(.bold)
            
            HStack {
                if lastestPriceInfo.change > 0 {
                    Image(systemName: "arrow.up.forward")
                }
                else if lastestPriceInfo.change < 0 {
                    Image(systemName: "arrow.down.forward")
                }
                
                Text("\(lastestPriceInfo.change, specifier: "%.2f")")
            }
            .foregroundColor(getColor())
        }
    }
    
    func getColor() -> Color {
        if lastestPriceInfo.change > 0 {
            return Color.green
        }
        else if lastestPriceInfo.change < 0 {
            return Color.red
        }
        else {
            return Color.gray
        }
    }
}
