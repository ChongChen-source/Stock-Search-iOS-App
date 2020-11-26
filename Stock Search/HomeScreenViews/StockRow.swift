//
//  StockRow.swift
//  Stock Search
//
//  Created by 陈冲 on 11/22/20.
//

import SwiftUI

struct StockRow: View {
    var stock: BasicStockInfo
    
    var body: some View {
        HStack {
            BasicStockInfoCell(stock: stock)
            Spacer()
            LatestPriceCell(ticker: stock.ticker)
        }
    }
}

struct StockRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StockRow(stock: testPortfolioStockArray[0])
            StockRow(stock: testPortfolioStockArray[1])
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

struct LatestPriceCell: View {
    var ticker: String
    var body: some View {
        VStack(alignment: .trailing) {
            Text("price")
            HStack {
                Image(systemName: "arrow.up.right")
                Text("change")
            }
        }
    }
}
