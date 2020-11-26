//
//  StockDetails.swift
//  Stock Search
//
//  Created by 陈冲 on 11/23/20.
//

import SwiftUI

struct StockDetails: View {
    var ticker: String
    var body: some View {
        Text(ticker)
    }
}

struct StockDetails_Previews: PreviewProvider {
    static var previews: some View {
        StockDetails(ticker: "ticker")
    }
}
