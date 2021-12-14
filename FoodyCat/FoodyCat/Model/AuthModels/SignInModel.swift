//
//  SignInModel.swift
//  FoodyCat
//
//  Created by Essam Orabi on 11/12/2021.
//

import Foundation

// MARK: - Welcome
class LoginInModel: Codable {
    let user: User?
    let token: String?
    let success: Bool?

    enum CodingKeys: String, CodingKey {
        case user = "user"
        case token = "token"
        case success = "success"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        user = try value.decodeIfPresent(User.self, forKey: .user)
        token = try value.decodeIfPresent(String.self, forKey: .token)
        success = try value.decodeIfPresent(Bool.self, forKey: .success)
    }

}

// MARK: - User
class User: Codable {
    let id, shopID: Int?
    let fName, lName, email: String?
    let newsletter: Bool?
    let birthDate: String?
    let gender: Int?
    let phone: String?
    let isGuest: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case shopID = "shopID"
        case fName = "fName"
        case lName = "lName"
        case email = "email"
        case newsletter = "newsletter"
        case birthDate = "birthDate"
        case gender = "gender"
        case phone = "phone"
        case isGuest = "isGuest"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        id = try value.decodeIfPresent(Int.self, forKey: .id)
        shopID = try value.decodeIfPresent(Int.self, forKey: .shopID)
        fName = try value.decodeIfPresent(String.self, forKey: .fName)
        lName = try value.decodeIfPresent(String.self, forKey: .lName)
        email = try value.decodeIfPresent(String.self, forKey: .email)
        newsletter = try value.decodeIfPresent(Bool.self, forKey: .newsletter)
        birthDate = try value.decodeIfPresent(String.self, forKey: .birthDate)
        gender = try value.decodeIfPresent(Int.self, forKey: .gender)
        phone = try value.decodeIfPresent(String.self, forKey: .phone)
        isGuest = try value.decodeIfPresent(Bool.self, forKey: .isGuest)
    }
}
