//
//  VendorVM.swift
//  FoodyCat
//
//  Created by Essam Orabi on 15/12/2021.
//

import Foundation

class VendorVM: ViewModel {
    var itemsResult: MenuItemModel?

    func getRestaurantData(vendorId: Int, onComplete: @escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {
        let params = [:] as [String : Any]
        let url = AppConstant.UrlHandler.getMenuItems + "\(vendorId)/menu"
        let  encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let resource = Resource<MenuItemModel>(url: encodedUrl,httpMethod:.get,parameters:params, header:SharedData.SharedInstans.getHeader())
        HttpApiCallingWithRep.requestWithBody(resource: resource) { (Result, StatusCode, Mesg, errorResponse) in
            if StatusCode == 200 {
                if let feeds = Result{
                    self.itemsResult = feeds
                    onComplete(nil, nil, .populated)
                } else {
                    onComplete(Mesg, errorResponse, .error)
                }
            } else {
                onComplete(Mesg, errorResponse, .error)
            }
        }
    }
    
}
