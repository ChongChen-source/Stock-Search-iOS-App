//
//  TradeSheetView.swift
//  Stock Search
//
//  Created by 陈冲 on 11/29/20.
//

import SwiftUI

struct TradeSheetView: View {
    @EnvironmentObject var localLists: LocalListsInfo
    @Binding var showTradeSheet: Bool
    @Binding var stock: BasicStockInfo
    @ObservedObject var latestPriceInfo: LatestPriceInfo
    
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
                            Text(getNumInput() > 1 ? "Shares" : "Share")
                                .font(.title)
                        }
                        HStack {
                            Spacer()
                            Text("x $\(latestPriceInfo.currPrice, specifier: "%.2f")/Share = $\(getCalcWorth(), specifier: "%.2f")")
                        }
                    }
                    Spacer()
                    Text("$\(self.availableWorth, specifier: "%.2f") available to buy \(stock.ticker)")
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                        .padding(.vertical)
                    HStack {
                        // Buy button
                        Button(action: withAnimation {{
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
                                    
                                    // update the stock info
                                    self.stock.sharesBought += getNumInput()
                                    
                                    // update the local portfolio list
                                    var portfolioStocks: [BasicStockInfo] = getLocalStocks(listName: listNamePortfolio)
                                    // case1: hasn't been bought before
                                    if !self.stock.isBought {
                                        stock.isBought = true
                                        portfolioStocks.append(stock)
                                    }
                                    // case2: has been bought before
                                    else {
                                        stock.isBought = true
                                        for (index, localStock) in portfolioStocks.enumerated() {
                                            if (localStock.ticker == stock.ticker) {
                                                portfolioStocks[index].isBought = stock.isBought
                                                portfolioStocks[index].sharesBought = stock.sharesBought
                                            }
                                        }
                                    }
                                    localLists.portfolioStocks = portfolioStocks
                                    setLocalStocks(localStocks: portfolioStocks, listName: listNamePortfolio)
                                    
                                    // update the local favourites list if needed
                                    var favoritesStocks: [BasicStockInfo] = getLocalStocks(listName: listNameFavorites)
                                    for (index, localStock) in favoritesStocks.enumerated() {
                                        if (localStock.ticker == stock.ticker) {
                                            favoritesStocks[index].isBought = stock.isBought
                                            favoritesStocks[index].sharesBought = stock.sharesBought
                                        }
                                    }
                                    localLists.favoritesStocks = favoritesStocks
                                    setLocalStocks(localStocks: favoritesStocks, listName: listNameFavorites)
                                    
                                    // update the worth
                                    self.showBoughtView.toggle()
                                }
                            } else {
                                self.showErrorInvalidInput = true
                            }
                        }}) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 40)
                                                .fill(Color.green)
                                Text("Buy")
                                    .foregroundColor(Color.white)
                            }
                            .padding(.trailing)
                            .frame(height: 60)
                        }
                        Spacer()
                        // Sell button
                        Button(action: withAnimation {{
                            if isValidInput() {
                                if stock.sharesBought < getNumInput() {
                                    self.showErrorNotEnoughShares = true
                                } else if getNumInput() <= 0 {
                                    self.showErrorSellNonpositiveShares = true
                                } else {
                                    // update the available worth and the net worth
                                    self.availableWorth = getAvailableWorth() + getCalcWorth()
                                    setAvailableWorth(availableWorth: self.availableWorth)
                                    localLists.availableWorth = self.availableWorth
                                    
                                    // update the stock info
                                    self.stock.sharesBought -= getNumInput()
                                    if self.stock.sharesBought == 0 {
                                        stock.isBought = false
                                    }
                                    
                                    // update the local portfolio
                                    var portfolioStocks: [BasicStockInfo] = getLocalStocks(listName: listNamePortfolio)
                                    var removeIndex: Int = -1
                                    for (index, localStock) in portfolioStocks.enumerated() {
                                        if (localStock.ticker == stock.ticker) {
                                            portfolioStocks[index].isBought = stock.isBought
                                            portfolioStocks[index].sharesBought = stock.sharesBought
                                            if (!stock.isBought) {
                                                removeIndex = index
                                            }
                                        }
                                    }
                                    if removeIndex != -1 {
                                        portfolioStocks.remove(at: removeIndex)
                                    }
                                    localLists.portfolioStocks = portfolioStocks
                                    setLocalStocks(localStocks: portfolioStocks, listName: listNamePortfolio)
                                    
                                    // update the local favourites list if needed
                                    var favoritesStocks: [BasicStockInfo] = getLocalStocks(listName: listNameFavorites)
                                    for (index, localStock) in favoritesStocks.enumerated() {
                                        if (localStock.ticker == stock.ticker) {
                                            favoritesStocks[index].isBought = stock.isBought
                                            favoritesStocks[index].sharesBought = stock.sharesBought
                                        }
                                    }
                                    localLists.favoritesStocks = favoritesStocks
                                    setLocalStocks(localStocks: favoritesStocks, listName: listNameFavorites)
                                    
                                    // update the worth
                                    self.showSoldView.toggle()
                                }
                            } else {
                                self.showErrorInvalidInput = true
                            }
                        }}) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 40)
                                                .fill(Color.green)
                                Text("Sell")
                                    .foregroundColor(Color.white)
                            }
                            .padding(.leading)
                            .frame(height: 60)
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
        .accentColor(.black)
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
        return getNumInput() * latestPriceInfo.currPrice
    }
}//view

struct TradeSheetView_Previews: PreviewProvider {
    @State static var showTradeSheet: Bool = false
    @State static var stock: BasicStockInfo = getBasicStockInfo(ticker: "AAPL")
    static var previews: some View {
        TradeSheetView(showTradeSheet: $showTradeSheet, stock: $stock, latestPriceInfo: LatestPriceInfo(ticker: stock.ticker))
    }
}
