//
//  DetailsPortfolioCell.swift
//  Stock Search
//
//  Created by 陈冲 on 11/29/20.
//

import SwiftUI

struct DetailsPortfolioCell: View {
    @State var stock: BasicStockInfo
    @State var basicPriceInfo: BasicPriceInfo
    @State var showTradeSheet: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            Text("Portfolio")
                .font(.title2)
                .padding(.vertical)
            HStack {
                if stock.isBought {
                    VStack(alignment: .leading) {
                        Text("Shares Owned: \(stock.sharesBought, specifier: "%.4f")")
                        Text("Market Value: $\(basicPriceInfo.currPrice, specifier: "%.2f")")
                    }
                } else {
                    VStack(alignment: .leading) {
                        Text("You have 0 shares of \(stock.ticker)")
                        Text("Start trading!")
                    }
                }
                Spacer()
                Button(action: withAnimation {{
                    self.showTradeSheet.toggle()
                }}) {
                    Text("Trade")
                        .font(.title3)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 16)
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .cornerRadius(40)
                }
                .sheet(isPresented: $showTradeSheet) {
                    TradeSheetView(showTradeSheet: $showTradeSheet, stock: $stock, basicPriceInfo: basicPriceInfo)
                        }
            }
        }
    }
}

struct DetailsPortfolioCell_Previews: PreviewProvider {
    static var previews: some View {
        DetailsPortfolioCell(stock: getBasicStockInfo(ticker: "AAPL"), basicPriceInfo: LatestPriceInfo(ticker: "AAPL").basicPriceInfo)
    }
}
