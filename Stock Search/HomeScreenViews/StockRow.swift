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
            BasicPriceInfoCell(basicPriceInfo: LatestPriceInfo(ticker: stock.ticker).basicPriceInfo)
        }
    }
}

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

struct BasicPriceInfoCell: View {
    @State var basicPriceInfo: BasicPriceInfo
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text("\(basicPriceInfo.currPrice, specifier: "%.2f")")
                .fontWeight(.bold)
            
            HStack {
                if basicPriceInfo.change > 0 {
                    Image(systemName: "arrow.up.forward")
                }
                else if basicPriceInfo.change < 0 {
                    Image(systemName: "arrow.down.forward")
                }
                
                Text("\(basicPriceInfo.change, specifier: "%.2f")")
            }
            .foregroundColor(getColor())
        }
    }
    
    func getColor() -> Color {
        if basicPriceInfo.change > 0 {
            return Color.green
        }
        else if basicPriceInfo.change < 0 {
            return Color.red
        }
        else {
            return Color.gray
        }
    }
}
