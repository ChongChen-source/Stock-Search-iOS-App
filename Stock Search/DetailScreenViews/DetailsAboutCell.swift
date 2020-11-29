//
//  DetailsAboutCell.swift
//  Stock Search
//
//  Created by 陈冲 on 11/29/20.
//

import SwiftUI

struct DetailsAboutCell: View {
    @State var description: String
    
    @State var isExpanded: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("About")
                .font(.title2)
            Text(description)
                .lineLimit( isExpanded ? nil: 2)
            HStack {
                Spacer()
                Button(action: { self.isExpanded.toggle()} ) {
                    Text(isExpanded ? "Show less" : "Show more...")
                        .foregroundColor(Color.gray)
                }
            }
         }
     }
}

struct DetailsAboutCell_Previews: PreviewProvider {
    static var previews: some View {
        DetailsAboutCell(description: getDescriptionInfo(ticker: "AAPL").description)
    }
}
