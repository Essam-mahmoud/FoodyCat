//
//  CeleberitiesModel.swift
//  FoodyCat
//
//  Created by Essam Orabi on 12/12/2021.
//

import Foundation


class CeleberitiesModel: Codable {
    let data: [CeleberitiesData]?
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
        data = try value.decodeIfPresent([CeleberitiesData].self, forKey: .data)
        currentPage = try value.decodeIfPresent(Int.self, forKey: .currentPage)
        pageCount = try value.decodeIfPresent(Int.self, forKey: .pageCount)
        pageSize = try value.decodeIfPresent(Int.self, forKey: .pageSize)
        rowCount = try value.decodeIfPresent(Int.self, forKey: .rowCount)
        firstRowOnPage = try value.decodeIfPresent(Int.self, forKey: .firstRowOnPage)
        lastRowOnPage = try value.decodeIfPresent(Int.self, forKey: .lastRowOnPage)
    }
}

// MARK: - Datum
class CeleberitiesData: Codable {
    let id: Int?
    let name: String?
    let mediaFullPath: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case mediaFullPath = "mediaFullPath"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        id = try value.decodeIfPresent(Int.self, forKey: .id)
        name = try value.decodeIfPresent(String.self, forKey: .name)
        mediaFullPath = try value.decodeIfPresent(String.self, forKey: .mediaFullPath)
    }
}
