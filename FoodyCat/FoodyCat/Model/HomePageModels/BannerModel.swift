//
//  BannerModel.swift
//  FoodyCat
//
//  Created by Essam Orabi on 14/12/2021.
//

import Foundation

class BannerModel: Codable {
    let data: [BannerData]?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"

    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        data = try value.decodeIfPresent([BannerData].self, forKey: .data)
        message = try value.decodeIfPresent(String.self, forKey: .message)
    }
}

// MARK: - Datum
class BannerData: Codable {
    let id: Int?
    let name: String?
    let clickId: Int?
    let imageFullPath: String?
    let headText, buttonText: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case clickId = "clickId"
        case imageFullPath = "imageFullPath"
        case headText = "headText"
        case buttonText = "buttonText"
    }
    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        id = try value.decodeIfPresent(Int.self, forKey: .id)
        name = try value.decodeIfPresent(String.self, forKey: .name)
        clickId = try value.decodeIfPresent(Int.self, forKey: .clickId)
        imageFullPath = try value.decodeIfPresent(String.self, forKey: .imageFullPath)
        headText = try value.decodeIfPresent(String.self, forKey: .headText)
        buttonText = try value.decodeIfPresent(String.self, forKey: .buttonText)
    }
}
