//
//  UserDataModel.swift
//  FoodyCat
//
//  Created by Essam Orabi on 21/04/2022.
//

import Foundation

// MARK: - Welcome
class UserDataModel: Codable {
    let data: UserDataClass?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        data = try value.decodeIfPresent(UserDataClass.self, forKey: .data)
        message = try value.decodeIfPresent(String.self, forKey: .message)
    }
}

// MARK: - DataClass
class UserDataClass: Codable {
    let user: UserData?
    let success: Bool?

    enum CodingKeys: String, CodingKey {
        case user = "user"
        case success = "success"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        user = try value.decodeIfPresent(UserData.self, forKey: .user)
        success = try value.decodeIfPresent(Bool.self, forKey: .success)
    }
}

// MARK: - User
class UserData: Codable {
    let id: Int?
    let fName, lName, email: String?
    let newsletter: Bool?
    let birthDate: String?
    let gender: Int?
    let phone: String?
    let isGuest: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
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
