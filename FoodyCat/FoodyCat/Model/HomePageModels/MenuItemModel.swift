//
//  MenuItemModel.swift
//  FoodyCat
//
//  Created by Essam Orabi on 15/12/2021.
//

import Foundation

class MenuItemModel: Codable {
    let data: [ItemsData]?
    let success: Bool?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case success = "success"
        case message = "message"

    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        data = try value.decodeIfPresent([ItemsData].self, forKey: .data)
        success = try value.decodeIfPresent(Bool.self, forKey: .success)
        message = try value.decodeIfPresent(String.self, forKey: .message)
    }
}

// MARK: - Datum
class ItemsData: Codable {
    let id: Int?
    let title: String?
    let items: [Item]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case items = "items"

    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        id = try value.decodeIfPresent(Int.self, forKey: .id)
        title = try value.decodeIfPresent(String.self, forKey: .title)
        items = try value.decodeIfPresent([Item].self, forKey: .items)
    }
}

// MARK: - Item
class Item: Codable {
    let orderID, id: Int?
    let name: String?
    let imgFullPath: String?
    let hasExtraTopping: Bool?
    let itemDescription: String?
    let veg, isNew: Bool?
    let price: Double?
    let discountPrice, packagingPrice: Int?

    enum CodingKeys: String, CodingKey {
        case orderID = "orderID"
        case id = "id"
        case name = "name"
        case imgFullPath = "imgFullPath"
        case hasExtraTopping = "hasExtraTopping"
        case itemDescription = "description"
        case veg = "veg"
        case isNew = "isNew"
        case price = "price"
        case discountPrice = "discountPrice"
        case packagingPrice = "packagingPrice"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        orderID = try value.decodeIfPresent(Int.self, forKey: .orderID)
        id = try value.decodeIfPresent(Int.self, forKey: .id)
        name = try value.decodeIfPresent(String.self, forKey: .name)
        imgFullPath = try value.decodeIfPresent(String.self, forKey: .imgFullPath)
        hasExtraTopping = try value.decodeIfPresent(Bool.self, forKey: .hasExtraTopping)
        itemDescription = try value.decodeIfPresent(String.self, forKey: .itemDescription)
        veg = try value.decodeIfPresent(Bool.self, forKey: .veg)
        isNew = try value.decodeIfPresent(Bool.self, forKey: .isNew)
        price = try value.decodeIfPresent(Double.self, forKey: .price)
        discountPrice = try value.decodeIfPresent(Int.self, forKey: .discountPrice)
        packagingPrice = try value.decodeIfPresent(Int.self, forKey: .packagingPrice)
    }
}

import Foundation

// MARK: - Welcome
class CelebritySuggestionItems: Codable {
    let data: [Item]?
    let success: Bool?
    let message: String?
    let requiredRedirect: Bool?
    let redirectURL: String?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case success = "success"
        case message = "message"
        case requiredRedirect = "requiredRedirect"
        case redirectURL = "redirectUrl"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        data = try value.decodeIfPresent([Item].self, forKey: .data)
        success = try value.decodeIfPresent(Bool.self, forKey: .success)
        message = try value.decodeIfPresent(String.self, forKey: .message)
        requiredRedirect = try value.decodeIfPresent(Bool.self, forKey: .requiredRedirect)
        redirectURL = try value.decodeIfPresent(String.self, forKey: .redirectURL)
    }
}


