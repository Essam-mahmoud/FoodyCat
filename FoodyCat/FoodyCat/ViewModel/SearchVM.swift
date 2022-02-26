//
//  SearchVM.swift
//  FoodyCat
//
//  Created by Essam Orabi on 26/02/2022.
//

import Foundation

class SearchVM: ViewModel {
    var vendors: VendorsModel?

    func getVendors(vendorName: String, onComplete: @escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {
        let areaId = SharedData.SharedInstans.getAreaId()
        let params = ["searchKey": vendorName] as [String : Any]
        let url = AppConstant.UrlHandler.getRestaurant + "\(areaId)"
        let  encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let resource = Resource<VendorsModel>(url: encodedUrl,httpMethod:.get,parameters:params, header:SharedData.SharedInstans.getHeader())
        HttpApiCallingWithRep.requestWithBody(resource: resource) { (Result, StatusCode, Mesg, errorResponse) in
            if StatusCode == 200 {
                if let feeds = Result{
                    self.vendors = feeds
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
