//
//  OrderDetailsVM.swift
//  FoodyCat
//
//  Created by Essam Orabi on 29/01/2022.
//

import Foundation

class OrderDetailsVM: ViewModel {
    var order: Order?

    func getOrder(id: Int, onComplete: @escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {

        let url = AppConstant.UrlHandler.orderDetails + "\(id)"
        let  encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let resource = Resource<Order>(url: encodedUrl,httpMethod:.get,parameters:[:], header:SharedData.SharedInstans.getHeader())
        HttpApiCallingWithRep.requestWithBody(resource: resource) { (Result, StatusCode, Mesg, errorResponse) in
            if StatusCode == 200 {
                if let feeds = Result{
                    self.order = feeds
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
