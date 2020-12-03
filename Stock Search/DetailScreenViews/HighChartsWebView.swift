//
//  HighChartsWebView.swift
//  Stock Search
//
//  Created by 陈冲 on 12/3/20.
//

import SwiftUI
import WebKit
import UIKit

struct HighChartsWebView: UIViewRepresentable {
    var ticker: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let localUrl = Bundle.main.url(forResource: "HighCharts", withExtension: "html", subdirectory: "HighCharts")!
        let url = URL(string: "?ticker=" + ticker, relativeTo: localUrl)!
        uiView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct HighChartsWebView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                HighChartsWebView(ticker: "AAPL")
            }
            .navigationBarTitle(Text("WKWebView"))
        }
    }
}
