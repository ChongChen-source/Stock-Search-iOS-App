//
//  TradeSheetView.swift
//  Stock Search
//
//  Created by 陈冲 on 11/29/20.
//

import SwiftUI

struct TradeSheetView: View {
    @EnvironmentObject var localLists: BasicStockInfoList
    @Binding var showTradeSheet: Bool
    @Binding var stock: BasicStockInfo
    
    @State var showBoughtView: Bool = false
    @State var showSoldView: Bool = false
    @State var availableWorth: Double = getAvailableWorth()
    
    @State var input: String = ""
    
    @State var showErrorNotEnoughShares: Bool = false //triggered by the Sell button
    @State var showErrorNotEnoughMoney: Bool = false //triggered by the Buy button
    @State var showErrorSellNonpositiveShares: Bool = false //triggered by the Sell button
    @State var showErrorBuyNonpositiveShares: Bool = false //triggered by the Buy button
    @State var showErrorInvalidInput: Bool = false //triggered by BOTH two buttons
    
    var body: some View {
        NavigationView {
            if (!showBoughtView && !showSoldView) {
                VStack {
                    Text("Trade \(stock.name) shares")
                        .fontWeight(.bold)
                    Spacer()
                    VStack {
                        HStack {
                            TextField("0", text: $input)
                                .keyboardType(.decimalPad)
                                .font(.system(size: 100))
                            Spacer()
                            Text("Share")
                                .font(.title)
                        }
                        HStack {
                            Spacer()
                            Text("x $\(getLatestPriceInfo(ticker: stock.ticker).lastPrice, specifier: "%.2f")/Share = $\(getCalcWorth(), specifier: "%.2f")")
                        }
                    }
                    Spacer()
                    Text("$\(self.availableWorth, specifier: "%.2f") available to buy \(stock.ticker)")
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                        .padding(.vertical)
                    HStack {
                        // Buy button
                        Button(action: {
                            if isValidInput() {
                                if getAvailableWorth() < getCalcWorth() {
                                    self.showErrorNotEnoughMoney = true
                                } else if getNumInput() <= 0 {
                                    self.showErrorBuyNonpositiveShares = true
                                } else {
                                    // update the available worth
                                    self.availableWorth = getAvailableWorth() - getCalcWorth()
                                    setAvailableWorth(availableWorth: self.availableWorth)
                                    localLists.availableWorth = self.availableWorth
                                    
                                    // update the local portfolio
                                    self.stock.sharesBought += getNumInput()
                                    self.stock.isBought = true
                                    var portfolioStocks: [BasicStockInfo] = getLocalStocks(listName: listNamePortfolio)
                                    if portfolioStocks.isEmpty {
                                        portfolioStocks.append(stock)
                                    } else {
                                        var i: Int = -1
                                        for (index, localStock) in portfolioStocks.enumerated() {
                                            if (localStock.ticker == stock.ticker) {
                                                i = index
                                            }
                                        }
                                        if i != -1 {
                                            portfolioStocks[i] = stock
                                        }
                                    }
                                    localLists.portfolioStocks = portfolioStocks
                                    setLocalStocks(localStocks: portfolioStocks, listName: listNamePortfolio)
                                    
                                    // update the worth
                                    self.showBoughtView.toggle()
                                }
                            } else {
                                self.showErrorInvalidInput = true
                            }
                        }) {
                            Text("Buy")
                                .font(.title3)
                                .padding(.horizontal, 50)
                                .padding(.vertical, 16)
                                .background(Color.green)
                                .foregroundColor(Color.white)
                                .cornerRadius(40)
                        }
                        
                        // Sell button
                        Button(action: withAnimation {{
                            if isValidInput() {
                                if stock.sharesBought < getNumInput() {
                                    self.showErrorNotEnoughShares = true
                                } else if getNumInput() <= 0 {
                                    self.showErrorSellNonpositiveShares = true
                                } else {
                                    // update the available worth
                                    self.availableWorth = getAvailableWorth() + getCalcWorth()
                                    setAvailableWorth(availableWorth: self.availableWorth)
                                    localLists.availableWorth = self.availableWorth
                                    
                                    // update the local portfolio
                                    self.stock.sharesBought -= getNumInput()
                                    if self.stock.sharesBought == 0 {
                                        stock.isBought = false
                                    }
                                    var portfolioStocks: [BasicStockInfo] = getLocalStocks(listName: listNamePortfolio)
                                    var i: Int = -1
                                    for (index, localStock) in portfolioStocks.enumerated() {
                                        if (localStock.ticker == stock.ticker) {
                                            i = index
                                        }
                                    }
                                    if i != -1 {
                                        if self.stock.sharesBought == 0 {
                                            portfolioStocks.remove(at: i)
                                        } else {
                                            portfolioStocks[i] = stock
                                        }
                                    }
                                    localLists.portfolioStocks = portfolioStocks
                                    setLocalStocks(localStocks: portfolioStocks, listName: listNamePortfolio)
                                    
                                    // update the worth
                                    self.showSoldView.toggle()
                                }
                            } else {
                                self.showErrorInvalidInput = true
                            }
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
                .padding(.horizontal)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button (action: withAnimation {{
                            self.showTradeSheet.toggle()
                        }}) {
                            Image(systemName: "xmark")
                        }
                    }
                }//toobar
                .toast(isPresented: self.$showErrorNotEnoughShares) {
                    Text("Not enough shares to sell")
                }
                .toast(isPresented: self.$showErrorNotEnoughMoney) {
                    Text("Not enough money to buy")
                }
                .toast(isPresented: self.$showErrorSellNonpositiveShares) {
                    Text("Cannot sell less than 0 share")
                }
                .toast(isPresented: self.$showErrorBuyNonpositiveShares) {
                    Text("Cannot buy less than 0 share")
                }
                .toast(isPresented: self.$showErrorInvalidInput) {
                    Text("Please enter a valid amount")
                }
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
                            if (getNumInput() > 1) {
                                Text("You have successfully bought \(getNumInput(), specifier: "%.2f") shares of \(stock.ticker)")
                                    .foregroundColor(Color.white)
                            } else {
                                Text("You have successfully bought \(getNumInput(), specifier: "%.2f") share of \(stock.ticker)")
                                    .foregroundColor(Color.white)
                            }
                        }
                        else if showSoldView {
                            if (getNumInput() > 1) {
                                Text("You have successfully sold \(getNumInput(), specifier: "%.2f") shares of \(stock.ticker)")
                                    .foregroundColor(Color.white)
                            } else {
                                Text("You have successfully sold \(getNumInput(), specifier: "%.2f") share of \(stock.ticker)")
                                    .foregroundColor(Color.white)
                            }
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
    
    func getNumInput() -> Double {
        if let num = Double(input) {
            return num
        } else {
            return 0.0
        }
    }
    
    func isValidInput() -> Bool {
        if Double(input) != nil {
            return true
        } else {
            return false
        }
    }
    
    func getCalcWorth() -> Double {
        return getNumInput() * getLatestPriceInfo(ticker: stock.ticker).lastPrice
    }
}//view

struct TradeSheetView_Previews: PreviewProvider {
    @State static var showTradeSheet: Bool = false
    @State static var stock: BasicStockInfo = testStocks[0]
    static var previews: some View {
        TradeSheetView(showTradeSheet: $showTradeSheet, stock: $stock)
    }
}
