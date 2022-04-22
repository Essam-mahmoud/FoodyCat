//
//  ChangePasswordVM.swift
//  FoodyCat
//
//  Created by Essam Orabi on 21/04/2022.
//

import Foundation

class ChangePasswordVM: ViewModel {

    var result: ResponseModel?
    func changeUserPassword(newPass: String, OldPass: String, onComplete: @escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {
        let url = AppConstant.UrlHandler.changeUserPassword
        let params = ["oldPassword":OldPass,
                      "newPassword":newPass] as [String : Any]
        let  encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let resource = Resource<ResponseModel>(url: encodedUrl,httpMethod:.post,parameters:params, header:SharedData.SharedInstans.getHeader())
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
