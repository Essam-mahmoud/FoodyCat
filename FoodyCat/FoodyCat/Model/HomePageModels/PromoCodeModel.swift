//
//  PromoCodeModel.swift
//  FoodyCat
//
//  Created by Essam Orabi on 21/04/2022.
//

import Foundation

class VoucherModel: Codable {
    let status: Bool?
    let amount: Double?
    let fixedAmount: Bool?
    let minmumOrderAmount, maximumOrderAmount: Int?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case amount = "amount"
        case fixedAmount = "fixedAmount"
        case minmumOrderAmount = "minmumOrderAmount"
        case maximumOrderAmount = "maximumOrderAmount"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        status = try value.decodeIfPresent(Bool.self, forKey: .status)
        amount = try value.decodeIfPresent(Double.self, forKey: .amount)
        fixedAmount = try value.decodeIfPresent(Bool.self, forKey: .fixedAmount)
        minmumOrderAmount = try value.decodeIfPresent(Int.self, forKey: .minmumOrderAmount)
        maximumOrderAmount = try value.decodeIfPresent(Int.self, forKey: .maximumOrderAmount)
    }
}
