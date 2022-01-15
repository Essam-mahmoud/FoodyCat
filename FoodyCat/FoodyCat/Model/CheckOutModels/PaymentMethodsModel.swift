//
//  PaymentMethodsModel.swift
//  FoodyCat
//
//  Created by Essam Orabi on 15/01/2022.
//

import Foundation

class PaymentMethods: Codable {
    let id: Int?
    let title, icon: String?
    let selected: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case icon = "icon"
        case selected = "selected"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        id = try value.decodeIfPresent(Int.self, forKey: .id)
        title = try value.decodeIfPresent(String.self, forKey: .title)
        icon = try value.decodeIfPresent(String.self, forKey: .icon)
        selected = try value.decodeIfPresent(Bool.self, forKey: .selected)
    }
}
