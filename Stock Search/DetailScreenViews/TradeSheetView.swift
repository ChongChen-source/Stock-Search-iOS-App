//
//  TradeSheetView.swift
//  Stock Search
//
//  Created by 陈冲 on 11/29/20.
//

import SwiftUI

struct TradeSheetView: View {
    @Binding var showTradeSheet: Bool
    @State var stock: BasicStockInfo
    
    @State var showBoughtView: Bool = false
    @State var showSoldView: Bool = false
    
    var body: some View {
        NavigationView {
            if (!showBoughtView && !showSoldView) {
                VStack {
                    Text("Trade \(stock.name) shares")
                    Text("$\(getAvailableWorth(), specifier: "%.2f") available to buy \(stock.ticker)")
                    HStack {
                        Button(action: {
                            self.showBoughtView.toggle()
                        }) {
                            Text("Buy")
                                .font(.title3)
                                .padding(.horizontal, 50)
                                .padding(.vertical, 16)
                                .background(Color.green)
                                .foregroundColor(Color.white)
                                .cornerRadius(40)
                        }
                        
                        Button(action: withAnimation {{
                            self.showSoldView.toggle()
                        }}) {
                            Text("Sell")
                                .font(.title3)
                                .padding(.horizontal, 50)
                                .padding(.vertical, 16)
                                .background(Color.green)
                                .foregroundColor(Color.white)
                                .cornerRadius(40)
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button (action: withAnimation {{
                            self.showTradeSheet.toggle()
                        }}) {
                            Image(systemName: "xmark")
                        }
                    }
                }//toobar
            } else {
                ZStack {
                    Color.green
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        Text("Congratuations!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding(.bottom)
                        if showBoughtView {
                            Text("You have successfully bought 1.15 shares of \(stock.ticker)")
                                .foregroundColor(Color.white)
                        }
                        else if showSoldView {
                            Text("You have successfully sold 1 share of \(stock.ticker)")
                                .foregroundColor(Color.white)
                        }
                        Spacer()
                        Button (action: withAnimation {{
                            self.showTradeSheet.toggle()
                        }}) {
                            Text("Done")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.green)
                                .background(Color.white)
                                .cornerRadius(40)
                        }
                        .padding(.horizontal)
                    }//VStack
                }//ZStack
            }
        }//NavigationView
    }//body
}//view

struct TradeSheetView_Previews: PreviewProvider {
    @State static var showTradeSheet: Bool = false
    @State static var stock: BasicStockInfo = testStocks[0]
    static var previews: some View {
        TradeSheetView(showTradeSheet: $showTradeSheet, stock: stock)
    }
}
