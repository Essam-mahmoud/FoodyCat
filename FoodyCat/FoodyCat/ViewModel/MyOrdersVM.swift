//
//  MyOrdersVM.swift
//  FoodyCat
//
//  Created by Essam Orabi on 31/01/2022.
//

import Foundation

class MyOrdersVM: ViewModel {
    var orders: MyOrdersModel?

    func getOrders(page: Int, onComplete: @escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {
        let params = ["page":page] as [String : Any]
        let url = AppConstant.UrlHandler.getOrders
        let  encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let resource = Resource<MyOrdersModel>(url: encodedUrl,httpMethod:.get,parameters:params, header:SharedData.SharedInstans.getHeader())
        HttpApiCallingWithRep.requestWithBody(resource: resource) { (Result, StatusCode, Mesg, errorResponse) in
            if StatusCode == 200 {
                if let feeds = Result{
                    self.orders = feeds
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
