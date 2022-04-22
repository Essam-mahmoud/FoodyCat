//
//  UserDataVM.swift
//  FoodyCat
//
//  Created by Essam Orabi on 21/04/2022.
//

import Foundation

class UserDataVM: ViewModel {
    var data: UserDataModel?
    var result: ResponseModel?

    func getUserInfo(onComplete: @escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {
        let url = AppConstant.UrlHandler.getUserInfo
        let  encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let resource = Resource<UserDataModel>(url: encodedUrl,httpMethod:.get,parameters:[:], header:SharedData.SharedInstans.getHeader())
        HttpApiCallingWithRep.requestWithBody(resource: resource) { (Result, StatusCode, Mesg, errorResponse) in
            if StatusCode == 200 {
                if let feeds = Result{
                    self.data = feeds
                    onComplete(nil, nil, .populated)
                } else {
                    onComplete(Mesg, errorResponse, .error)
                }
            } else {
                onComplete(Mesg, errorResponse, .error)
            }
        }
    }

    func updateUserInfo(name: String, email: String, onComplete: @escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {
        let url = AppConstant.UrlHandler.getUserInfo
        let params = ["fName":name,
                      "lName":"",
                      "email":email] as [String : Any]
        print(email)
        let  encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let resource = Resource<ResponseModel>(url: encodedUrl,httpMethod:.put,parameters:params, header:SharedData.SharedInstans.getHeader())
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
