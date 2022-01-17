//
//  SubmitOrderVM.swift
//  FoodyCat
//
//  Created by Essam Orabi on 17/01/2022.
//

import Foundation

class SubmitOrderVM: ViewModel {

    var submitResult: OrderResultModel?

    func submitOrder(params: [String : Any], onComplete: @escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {

        let url = AppConstant.UrlHandler.submitOrder
        let  encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let resource = Resource<OrderResultModel>(url: encodedUrl,httpMethod:.post,parameters:params, header:SharedData.SharedInstans.getHeader())
        HttpApiCallingWithRep.requestWithBody(resource: resource) { (Result, StatusCode, Mesg, errorResponse) in
            if StatusCode == 200 {
                if let feeds = Result{
                    self.submitResult = feeds
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
