//
//  DescriptionInfo.swift
//  Stock Search
//
//  Created by 陈冲 on 11/28/20.
//

import Foundation

struct DescriptionInfo {
    var ticker: String
    var name: String
    var description: String
}

func getDescriptionInfo(ticker: String) -> DescriptionInfo {
    // call API
    // pharse JSON
    let fetchedData: CompanyDescriptionAPI = testCompanyDescriptionData
    let info: DescriptionInfo = DescriptionInfo(ticker: ticker, name: fetchedData.name, description: fetchedData.description)
    return info
}
