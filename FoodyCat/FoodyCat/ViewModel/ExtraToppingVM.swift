//
//  ExtraToppingVM.swift
//  FoodyCat
//
//  Created by Essam Orabi on 17/12/2021.
//

import Foundation

class ExtraToppingVM: ViewModel {

    var extraData: ExtraToppingModel?

    func getExtraToopingData(itemId: Int, onComplete: @escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {
        let params = [:] as [String : Any]
        let url = AppConstant.UrlHandler.getMenuItems + "\(itemId)/menu/topping"
        let  encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let resource = Resource<ExtraToppingModel>(url: encodedUrl,httpMethod:.get,parameters:params, header:SharedData.SharedInstans.getHeader())
        HttpApiCallingWithRep.requestWithBody(resource: resource) { (Result, StatusCode, Mesg, errorResponse) in
            if StatusCode == 200 {
                if let feeds = Result{
                    self.extraData = feeds
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
