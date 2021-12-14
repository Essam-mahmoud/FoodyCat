//
//  CreateAccountModel.swift
//  FoodyCat
//
//  Created by Essam Orabi on 11/12/2021.
//

import Foundation

class createAccountModel: Codable {
    let data, message: String?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        data = try value.decodeIfPresent(String.self, forKey: .data)
        message = try value.decodeIfPresent(String.self, forKey: .message)
    }
}

