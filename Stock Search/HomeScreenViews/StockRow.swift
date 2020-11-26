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
        Text(stock.ticker)
    }
}

struct StockRow_Previews: PreviewProvider {
    static var previews: some View {
        StockRow(stock: testPortfolioList[0])
    }
}
