//
//  CompnayDescriptionAPI.swift
//  Stock Search
//
//  Created by 陈冲 on 11/28/20.
//

import Foundation

struct CompanyDescriptionAPI: Hashable, Codable {
    var exchangeCode: String
    var description: String
    var ticker: String
    var startDate: String
    var name: String
    var endDate: String
}
