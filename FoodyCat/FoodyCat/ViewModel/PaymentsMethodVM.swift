//
//  PaymentsMethodVM.swift
//  FoodyCat
//
//  Created by Essam Orabi on 15/01/2022.
//

import Foundation

class PaymentsMethodVM: ViewModel {
    var methods: [PaymentMethods]?

    func getPaymentsMethods(onComplete: @escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {
        let params = [:] as [String : Any]
        let vendorId = SharedData.SharedInstans.getVendorId()
        let url = AppConstant.UrlHandler.getPayments + "\(vendorId)/payment/options"
        let  encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let resource = Resource<[PaymentMethods]>(url: encodedUrl,httpMethod:.get,parameters:params, header:SharedData.SharedInstans.getHeader())
        HttpApiCallingWithRep.requestWithBody(resource: resource) { (Result, StatusCode, Mesg, errorResponse) in
            if StatusCode == 200 {
                if let feeds = Result{
                    self.methods = feeds
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
