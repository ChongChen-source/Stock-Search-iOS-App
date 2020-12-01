//
//  DetailsAboutCell.swift
//  Stock Search
//
//  Created by 陈冲 on 11/29/20.
//

import SwiftUI

struct DetailsAboutSection: View {
    @ObservedObject var descriptionInfo: DescriptionInfo
    
    @State var isExpanded: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("About")
                .font(.title2)
                .padding(.vertical)
            Text(descriptionInfo.description)
                .lineLimit( isExpanded ? nil: 2)
            HStack {
                Spacer()
                Button(action: {withAnimation{(self.isExpanded.toggle())}} ) {
                    Text(isExpanded ? "Show less" : "Show more...")
                        .foregroundColor(Color.gray)
                }
            }
         }
     }
}

struct DetailsAboutSection_Previews: PreviewProvider {
    static var previews: some View {
        DetailsAboutSection(descriptionInfo: DescriptionInfo(ticker: "AAPL"))
    }
}
