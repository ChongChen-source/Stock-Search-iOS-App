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
//        let localUrl = Bundle.main.url(forResource: "HighCharts", withExtension: "html", subdirectory: "HighCharts")!
//        let url = URL(string: "?ticker=" + ticker, relativeTo: localUrl)!
//        uiView.loadFileURL(url, allowingReadAccessTo: url)
        let urlStr = "http://localhost:8080/high-charts/" + ticker
        let url = URL(string: urlStr)!
        let request = URLRequest(url: url)
        print("request WebView: " + urlStr)
        uiView.load(request)
        uiView.scrollView.isScrollEnabled = false
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
