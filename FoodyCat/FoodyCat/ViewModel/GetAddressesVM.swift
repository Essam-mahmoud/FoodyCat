//
//  GetAddressesVM.swift
//  FoodyCat
//
//  Created by Essam Orabi on 15/01/2022.
//

import Foundation

class AddressesVM: ViewModel {

    var addressesResult: Addresses?
    var addAddressResult: AddressData?

    func getAddresses(page: Int, onComplete: @escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {
        let areaId = SharedData.SharedInstans.getAreaId()
        let params = ["page": page,
                      "areaId": areaId] as [String : Any]
        let url = AppConstant.UrlHandler.getAddresses
        let  encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let resource = Resource<Addresses>(url: encodedUrl,httpMethod:.get,parameters:params, header:SharedData.SharedInstans.getHeader())
        HttpApiCallingWithRep.requestWithBody(resource: resource) { (Result, StatusCode, Mesg, errorResponse) in
            if StatusCode == 200 {
                if let feeds = Result{
                    self.addressesResult = feeds
                    onComplete(nil, nil, .populated)
                } else {
                    onComplete(Mesg, errorResponse, .error)
                }
            } else {
                onComplete(Mesg, errorResponse, .error)
            }
        }
    }

    func addAddress(address: String,extaInfo: String, phone: String, onComplete: @escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {
        let areaId = SharedData.SharedInstans.getAreaId()
        let params = ["name": "home",
                      "areaId": areaId,
                      "addressLineOne":address,
                      "addressLineTwo":extaInfo,
                      "phone":phone,
                      "id":0,
                      "channel":0] as [String : Any]
        let url = AppConstant.UrlHandler.getAddresses
        let  encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let resource = Resource<AddressData>(url: encodedUrl,httpMethod:.post,parameters:params, header:SharedData.SharedInstans.getHeader())
        HttpApiCallingWithRep.requestWithBody(resource: resource) { (Result, StatusCode, Mesg, errorResponse) in
            if StatusCode == 200 {
                if let feeds = Result{
                    self.addAddressResult = feeds
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
