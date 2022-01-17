//
//  AddressModel.swift
//  FoodyCat
//
//  Created by Essam Orabi on 15/01/2022.
//

import Foundation

class Addresses: Codable {
    let data: [AddressData]?
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
        data = try value.decodeIfPresent([AddressData].self, forKey: .data)
        currentPage = try value.decodeIfPresent(Int.self, forKey: .currentPage)
        pageCount = try value.decodeIfPresent(Int.self, forKey: .pageCount)
        pageSize = try value.decodeIfPresent(Int.self, forKey: .pageSize)
        rowCount = try value.decodeIfPresent(Int.self, forKey: .rowCount)
        firstRowOnPage = try value.decodeIfPresent(Int.self, forKey: .firstRowOnPage)
        lastRowOnPage = try value.decodeIfPresent(Int.self, forKey: .lastRowOnPage)
    }
}

// MARK: - Datum
class AddressData: Codable {
    let lat, lng, name, addressLineOne: String?
    let addressLineTwo: String?
    let id, areaID: Int?
    let areaName: String?
    let phone: String?

    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
        case name = "name"
        case addressLineOne = "addressLineOne"
        case addressLineTwo = "addressLineTwo"
        case id = "id"
        case areaID = "areaID"
        case areaName = "areaName"
        case phone = "phone"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        lat = try value.decodeIfPresent(String.self, forKey: .lat)
        lng = try value.decodeIfPresent(String.self, forKey: .lng)
        name = try value.decodeIfPresent(String.self, forKey: .name)
        addressLineOne = try value.decodeIfPresent(String.self, forKey: .addressLineOne)
        addressLineTwo = try value.decodeIfPresent(String.self, forKey: .addressLineTwo)
        id = try value.decodeIfPresent(Int.self, forKey: .id)
        areaID = try value.decodeIfPresent(Int.self, forKey: .areaID)
        areaName = try value.decodeIfPresent(String.self, forKey: .areaName)
        phone = try value.decodeIfPresent(String.self, forKey: .phone)
    }
}
