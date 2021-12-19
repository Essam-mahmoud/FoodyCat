//
//  ExtraToppingModel.swift
//  FoodyCat
//
//  Created by Essam Orabi on 17/12/2021.
//

import Foundation

class ExtraToppingModel: Codable {
    let data: [ExtaToppingData]?
    let success: Bool?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case success = "success"
        case message = "message"

    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        data = try value.decodeIfPresent([ExtaToppingData].self, forKey: .data)
        success = try value.decodeIfPresent(Bool.self, forKey: .success)
        message = try value.decodeIfPresent(String.self, forKey: .message)
    }
}

// MARK: - Datum
class ExtaToppingData: Codable {
    let id: Int?
    let title: String?
    let isRequired: Bool?
    let maxQty, minQty, orderID: Int?
    let items: [ExtraItem]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case isRequired = "isRequired"
        case maxQty = "maxQty"
        case minQty = "minQty"
        case orderID = "orderID"
        case items = "items"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        id = try value.decodeIfPresent(Int.self, forKey: .id)
        title = try value.decodeIfPresent(String.self, forKey: .title)
        isRequired = try value.decodeIfPresent(Bool.self, forKey: .isRequired)
        maxQty = try value.decodeIfPresent(Int.self, forKey: .maxQty)
        minQty = try value.decodeIfPresent(Int.self, forKey: .minQty)
        orderID = try value.decodeIfPresent(Int.self, forKey: .orderID)
        items = try value.decodeIfPresent([ExtraItem].self, forKey: .items)
    }
}

// MARK: - Item
class ExtraItem: Codable {
    let id: Int?
    let title: String?
    let catID, price: Int?
    var isSelected: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case catID = "catID"
        case price = "price"
        case isSelected = "isSelected"

    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        id = try value.decodeIfPresent(Int.self, forKey: .id)
        title = try value.decodeIfPresent(String.self, forKey: .title)
        catID = try value.decodeIfPresent(Int.self, forKey: .catID)
        price = try value.decodeIfPresent(Int.self, forKey: .price)
        isSelected = try value.decodeIfPresent(Bool.self, forKey: .isSelected)
    }
}
