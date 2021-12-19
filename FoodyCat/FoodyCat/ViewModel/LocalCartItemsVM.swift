//
//  LocalCartItemsVM.swift
//  FoodyCat
//
//  Created by Essam Orabi on 18/12/2021.
//

import Foundation
import RealmSwift

protocol RealmViewModelDelegate {
    func recordSaved()
    func recordSavingFaild(error: NSError)
    func recordFetch(items: [ItemOrderModel])
    func recordDeleted()
}

extension RealmViewModelDelegate {
    func recordSaved() {}
    func recordSavingFaild(error: NSError) {}
    func recordFetch(items: [ItemOrderModel]) {}
    func recordDeleted() {}
}

class LocalCartItemsVM: NSObject {
    let realm = try! Realm()
    var delegate: RealmViewModelDelegate?

    func saveItem(item: ItemOrderModel) {
        try! realm.write {
            realm.add(item)
            delegate?.recordSaved() // notify Succssful insertion
        }
    }

    func fetchItems() {
        let items = realm.objects(ItemOrderModel.self)
        if items.count > 0 {
            var tempItems = [ItemOrderModel]()
            for item in items {
                tempItems.append(item)
            }
            delegate?.recordFetch(items: tempItems)
        } else {
            delegate?.recordFetch(items: [])
        }
    }

    func deleteItem(item: ItemOrderModel) {
        try! realm.write {
            realm.delete(item)
            delegate?.recordDeleted()
        }
    }
}
