//
//  VoucherVM.swift
//  FoodyCat
//
//  Created by Essam Orabi on 02/02/2022.
//

import Foundation

class VoucherVM: ViewModel {
    var result: ResponseModel?

    func getDiscount(vendorId: String, code: String, onComplete: @escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {

        let url = AppConstant.UrlHandler.getDiscount + vendorId + "/" + code
        let  encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let resource = Resource<ResponseModel>(url: encodedUrl,httpMethod:.get,parameters:[:], header:SharedData.SharedInstans.getHeader())
        HttpApiCallingWithRep.requestWithBody(resource: resource) { (Result, StatusCode, Mesg, errorResponse) in
            if StatusCode == 200 {
                if let feeds = Result{
                    self.result = feeds
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
