//
//  GetAreaIdModel.swift
//  FoodyCat
//
//  Created by Essam Orabi on 15/01/2022.
//

import Foundation

class GetAreaIdModel: Codable {
    let areaID: Int?
    let areas: [String]?
    let area, addressLineOne: String?
    let lat, lng: Double?

    enum CodingKeys: String, CodingKey {
        case areaID = "areaId"
        case areas = "areas"
        case area = "area"
        case addressLineOne = "addressLineOne"
        case lat = "lat"
        case lng = "lng"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        areaID = try value.decodeIfPresent(Int.self, forKey: .areaID)
        areas = try value.decodeIfPresent([String].self, forKey: .areas)
        area = try value.decodeIfPresent(String.self, forKey: .area)
        addressLineOne = try value.decodeIfPresent(String.self, forKey: .addressLineOne)
        lat = try value.decodeIfPresent(Double.self, forKey: .lat)
        lng = try value.decodeIfPresent(Double.self, forKey: .lng)
    }
}

struct Place {
    let name: String
    let identifier: String
}

enum PlacesError: Error {
    case faildToFind
    case faildToGetCoordinate
}

struct SavedAddressesModel: Codable {
    let areaId: Int?
    let address: String?
    let long: Double?
    let lat: Double?
    let areaName: String?

    init(areaId: Int, address: String, long: Double, lat: Double, areaName: String) {
        self.areaId = areaId
        self.address = address
        self.long = long
        self.lat = lat
        self.areaName = areaName
    }
}
