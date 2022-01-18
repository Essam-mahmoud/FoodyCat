//
//  SubmitOrderModel.swift
//  FoodyCat
//
//  Created by Essam Orabi on 17/01/2022.
//

import Foundation

// MARK: - Welcome
class OrderResultModel: Codable {
    let data: DataClass?
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
        data = try value.decodeIfPresent(DataClass.self, forKey: .data)
        success = try value.decodeIfPresent(Bool.self, forKey: .success)
        message = try value.decodeIfPresent(String.self, forKey: .message)
        requiredRedirect = try value.decodeIfPresent(Bool.self, forKey: .requiredRedirect)
        redirectURL = try value.decodeIfPresent(String.self, forKey: .redirectURL)
    }
}

// MARK: - DataClass
class DataClass: Codable {
    let order: Order?
    let paymentDetails: String?

    enum CodingKeys: String, CodingKey {
        case order = "order"
        case paymentDetails = "paymentDetails"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        order = try value.decodeIfPresent(Order.self, forKey: .order)
        paymentDetails = try value.decodeIfPresent(String.self, forKey: .paymentDetails)
    }
}

// MARK: - Order
class Order: Codable {
    let currentStep: Int?
    let currentStepString: String?
    let id: Int?
    let mapAvailable: Bool?
    let orderDate: String?
    let grandTotal: Double?
    let paymentMethod, status, vatAmount: Int?
    let deliveryCharges, discountAmount, subTotal: Double?
    let type: Int?
   // let note, mapUUID: String?
    let voucherAmount: Int?
    let generalRequest: String?
    let address: Address?
    let vendor: Vendor?
    let listOfCart: [ListOfCart]?
    let paymentDetails: [PaymentDetail]?

    enum CodingKeys: String, CodingKey {
        case currentStep = "currentStep"
        case currentStepString = "currentStepString"
        case id = "id"
        case mapAvailable = "mapAvailable"
        case orderDate = "orderDate"
        case grandTotal = "grandTotal"
        case paymentMethod = "paymentMethod"

        case status = "status"
        case vatAmount = "vatAmount"
        case deliveryCharges = "deliveryCharges"
        case discountAmount = "discountAmount"
        case subTotal = "subTotal"
        case type = "type"
        //case note = "note"
        //case mapUUID = "mapUUID"

        case voucherAmount = "voucherAmount"
        case generalRequest = "generalRequest"
        case address = "address"
        case vendor = "vendor"
        case listOfCart = "listOfCart"
        case paymentDetails = "paymentDetails"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        currentStep = try value.decodeIfPresent(Int.self, forKey: .currentStep)
        currentStepString = try value.decodeIfPresent(String.self, forKey: .currentStepString)
        id = try value.decodeIfPresent(Int.self, forKey: .id)
        mapAvailable = try value.decodeIfPresent(Bool.self, forKey: .mapAvailable)
        orderDate = try value.decodeIfPresent(String.self, forKey: .orderDate)
        grandTotal = try value.decodeIfPresent(Double.self, forKey: .grandTotal)
        paymentMethod = try value.decodeIfPresent(Int.self, forKey: .paymentMethod)

        status = try value.decodeIfPresent(Int.self, forKey: .status)
        vatAmount = try value.decodeIfPresent(Int.self, forKey: .vatAmount)
        deliveryCharges = try value.decodeIfPresent(Double.self, forKey: .deliveryCharges)
        discountAmount = try value.decodeIfPresent(Double.self, forKey: .discountAmount)
        subTotal = try value.decodeIfPresent(Double.self, forKey: .subTotal)
        type = try value.decodeIfPresent(Int.self, forKey: .type)
        //note = try value.decodeIfPresent(String.self, forKey: .note)
        //mapUUID = try value.decodeIfPresent(String.self, forKey: .mapUUID)

        voucherAmount = try value.decodeIfPresent(Int.self, forKey: .voucherAmount)
        generalRequest = try value.decodeIfPresent(String.self, forKey: .generalRequest)
        address = try value.decodeIfPresent(Address.self, forKey: .address)
        vendor = try value.decodeIfPresent(Vendor.self, forKey: .vendor)
        listOfCart = try value.decodeIfPresent([ListOfCart].self, forKey: .listOfCart)
        paymentDetails = try value.decodeIfPresent([PaymentDetail].self, forKey: .paymentDetails)
    }
}

// MARK: - Address
class Address: Codable {
    let lat, lng: String?
    let id: Int?
    let addressLineOne, addressLineTwo, phone: String?

    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
        case id = "id"
        case addressLineOne = "addressLineOne"
        case addressLineTwo = "addressLineTwo"
        case phone = "phone"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        lat = try value.decodeIfPresent(String.self, forKey: .lat)
        lng = try value.decodeIfPresent(String.self, forKey: .lng)
        id = try value.decodeIfPresent(Int.self, forKey: .id)
        addressLineOne = try value.decodeIfPresent(String.self, forKey: .addressLineOne)
        addressLineTwo = try value.decodeIfPresent(String.self, forKey: .addressLineTwo)
        phone = try value.decodeIfPresent(String.self, forKey: .phone)
    }
}

// MARK: - ListOfCart
class ListOfCart: Codable {
    let details, name: String?
    let itemID, id, qty: Int?
    let price: Double?
    let specialRequest: String?

    enum CodingKeys: String, CodingKey {
        case details = "details"
        case name = "name"
        case itemID = "itemID"
        case id = "id"
        case qty = "qty"
        case price = "price"
        case specialRequest = "specialRequest"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        details = try value.decodeIfPresent(String.self, forKey: .details)
        name = try value.decodeIfPresent(String.self, forKey: .name)
        itemID = try value.decodeIfPresent(Int.self, forKey: .itemID)
        id = try value.decodeIfPresent(Int.self, forKey: .id)
        qty = try value.decodeIfPresent(Int.self, forKey: .qty)
        price = try value.decodeIfPresent(Double.self, forKey: .price)
        specialRequest = try value.decodeIfPresent(String.self, forKey: .specialRequest)
    }
}

// MARK: - PaymentDetail
class PaymentDetail: Codable {
    let amount: Double?
    let title: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case title = "title"
        case id = "id"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        amount = try value.decodeIfPresent(Double.self, forKey: .amount)
        title = try value.decodeIfPresent(String.self, forKey: .title)
        id = try value.decodeIfPresent(Int.self, forKey: .id)
    }
}

// MARK: - Vendor
class Vendor: Codable {
    let vendorID: Int?
    let name: String?
    let logoFullPath: String?
    //let phone: String?

    enum CodingKeys: String, CodingKey {
        case vendorID = "vendorID"
        case name = "name"
        case logoFullPath = "logoFullPath"
       // case phone = "phone"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        vendorID = try value.decodeIfPresent(Int.self, forKey: .vendorID)
        name = try value.decodeIfPresent(String.self, forKey: .name)
        logoFullPath = try value.decodeIfPresent(String.self, forKey: .logoFullPath)
        //phone = try value.decodeIfPresent(String.self, forKey: .phone)
    }
}

