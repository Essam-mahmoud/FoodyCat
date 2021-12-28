//
//  CelibritiesRestaurantModel.swift
//  FoodyCat
//
//  Created by Essam Orabi on 13/12/2021.
//

import Foundation

class VendorsModel: Codable {
    let data: [VendorsData]?
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
        data = try value.decodeIfPresent([VendorsData].self, forKey: .data)
        currentPage = try value.decodeIfPresent(Int.self, forKey: .currentPage)
        pageCount = try value.decodeIfPresent(Int.self, forKey: .pageCount)
        pageSize = try value.decodeIfPresent(Int.self, forKey: .pageSize)
        rowCount = try value.decodeIfPresent(Int.self, forKey: .rowCount)
        firstRowOnPage = try value.decodeIfPresent(Int.self, forKey: .firstRowOnPage)
        lastRowOnPage = try value.decodeIfPresent(Int.self, forKey: .lastRowOnPage)
    }
}

// MARK: - Datum
class VendorsData: Codable {
    let id: Int?
    let name: String?
    let logo: String?
    let rating, reviews: Int?
    let phone: String?
    let vendorCharges, acceptanceDuration, preparationDuration: Int?
    let vendorOpen: Bool?
    let openingStatus: Int?
    let busy: Bool?
 // let minimumOrder: Int?
    let acceptOrders: Bool?
    let deliveryCharge: Double?
    let averageDeliveryTime: Int?
    let address: String?
    let vat: Int?
    let cuisines: String?
    //let timing: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logo = "logo"
        case rating = "rating"
        case reviews = "reviews"
        case phone = "phone"
        case vendorCharges = "vendorCharges"
        case acceptanceDuration = "acceptanceDuration"
        case preparationDuration = "preparationDuration"
        case vendorOpen = "open"
        case openingStatus = "openingStatus"
        case busy = "busy"
   //   case minimumOrder = "minimumOrder"
        case acceptOrders = "acceptOrders"
        case deliveryCharge = "deliveryCharge"
        case averageDeliveryTime = "averageDeliveryTime"
        case address = "address"
        case vat = "vat"
        case cuisines = "cuisines"
        //case timing = "timing"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        id = try value.decodeIfPresent(Int.self, forKey: .id)
        name = try value.decodeIfPresent(String.self, forKey: .name)
        logo = try value.decodeIfPresent(String.self, forKey: .logo)
        rating = try value.decodeIfPresent(Int.self, forKey: .rating)
        reviews = try value.decodeIfPresent(Int.self, forKey: .reviews)
        phone = try value.decodeIfPresent(String.self, forKey: .phone)
        vendorCharges = try value.decodeIfPresent(Int.self, forKey: .vendorCharges)
        acceptanceDuration = try value.decodeIfPresent(Int.self, forKey: .acceptanceDuration)
        preparationDuration = try value.decodeIfPresent(Int.self, forKey: .preparationDuration)
        vendorOpen = try value.decodeIfPresent(Bool.self, forKey: .vendorOpen)
        openingStatus = try value.decodeIfPresent(Int.self, forKey: .openingStatus)
        busy = try value.decodeIfPresent(Bool.self, forKey: .busy)
    //  minimumOrder = try value.decodeIfPresent(Int.self, forKey: .minimumOrder)
        acceptOrders = try value.decodeIfPresent(Bool.self, forKey: .acceptOrders)
        deliveryCharge = try value.decodeIfPresent(Double.self, forKey: .deliveryCharge)
        averageDeliveryTime = try value.decodeIfPresent(Int.self, forKey: .averageDeliveryTime)
        address = try value.decodeIfPresent(String.self, forKey: .address)
        vat = try value.decodeIfPresent(Int.self, forKey: .vat)
        cuisines = try value.decodeIfPresent(String.self, forKey: .cuisines)
        //timing = try value.decodeIfPresent(String.self, forKey: .timing)
    }
}
