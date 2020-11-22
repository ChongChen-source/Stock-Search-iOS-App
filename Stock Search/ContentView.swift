//
//  ContentView.swift
//  Stock Search
//
//  Created by 陈冲 on 11/18/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            
        VStack(alignment: .leading) {
            Text("Hello")
                .font(.title)
                
            HStack {
                Text("New Line")
                Spacer()
                Text("Placeholder")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
