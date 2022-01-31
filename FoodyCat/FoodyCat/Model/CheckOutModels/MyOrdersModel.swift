//
//  MyOrdersModel.swift
//  FoodyCat
//
//  Created by Essam Orabi on 31/01/2022.
//

import Foundation

class MyOrdersModel: Codable {

    let data: [Order]?
    let currentPage, pageCount, pageSize, rowCount: Int?
    let firstRowOnPage, lastRowOnPage: Int?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case currentPage = "currentPage"
        case pageCount = "pageCount"
        case pageSize = "pageSize"
        case rowCount = "rowCount"
        case firstRowOnPage = "firstRowOnPage"
        case lastRowOnPage = "lastRowOnPage"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        data = try value.decodeIfPresent([Order].self, forKey: .data)
        currentPage = try value.decodeIfPresent(Int.self, forKey: .currentPage)
        pageCount = try value.decodeIfPresent(Int.self, forKey: .pageCount)
        pageSize = try value.decodeIfPresent(Int.self, forKey: .pageSize)
        rowCount = try value.decodeIfPresent(Int.self, forKey: .rowCount)
        firstRowOnPage = try value.decodeIfPresent(Int.self, forKey: .firstRowOnPage)
        lastRowOnPage = try value.decodeIfPresent(Int.self, forKey: .lastRowOnPage)
    }
}
