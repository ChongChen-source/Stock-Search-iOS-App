//
//  TradeSheetView.swift
//  Stock Search
//
//  Created by 陈冲 on 11/29/20.
//

import SwiftUI

struct TradeSheetView: View {
    @Binding var showTradeSheet: Bool
    var body: some View {
        NavigationView {
            Text("Trade Sheet")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button (action: withAnimation {{
                            self.showTradeSheet.toggle()
                        }}) {
                            Image(systemName: "xmark")
                        }
                    }
                }
        }
    }
}
