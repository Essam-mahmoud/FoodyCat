//
//  ItemOrderModel.swift
//  FoodyCat
//
//  Created by Essam Orabi on 18/12/2021.
//

import Foundation
import RealmSwift

class ItemOrderModel: Object{
    @objc dynamic var Id: Int = 0
    @objc dynamic var quantity: Int = 0
    @objc dynamic var specialRequest: String = ""
    @objc dynamic var itemImageURL: String = ""
    @objc dynamic var itemName: String = ""
    @objc dynamic var itemDescription: String = ""
    @objc dynamic var itemPrice: Double = 0.0
    @objc dynamic var itemtotalPrice: Double = 0.0
    @objc dynamic var itemNote: String = ""
    var topping = RealmSwift.List<ItemTopping>()
}

class ItemTopping: Object {
    @objc dynamic var toppingId: Int = 0
    @objc dynamic var toppingPrice: Int = 0
}

