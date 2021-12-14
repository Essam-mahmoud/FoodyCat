//
//  SignInVM.swift
//  FoodyCat
//
//  Created by Essam Orabi on 11/12/2021.
//

import Foundation

class SignInVM: ViewModel {
    var result: LoginInModel?

    func UserLogin(phone: String, password: String, onComplete:@escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {

        let params = ["phone":phone,
                      "password":password
            ] as [String : Any]

        let resource = Resource<LoginInModel>(url:AppConstant.UrlHandler.Login,httpMethod:.post,parameters:params, header: AppCommon.sharedInstance.getHeader(AddtionParms: [:]))

        HttpApiCallingWithRep.requestWithBody(resource: resource){
            (Result, StatusCode, Mesg ,errorResponse) in
            if StatusCode == 200 {
                if let customerData = Result {
                    self.result = customerData
                    SharedData.SharedInstans.settoken(customerData.token ?? "")
                    onComplete(nil ,nil,.populated)
                }else{
                    onComplete(Mesg ,errorResponse,.error)
                }
            }else{
                onComplete(Mesg ,errorResponse,.error)
            }
        }
    }
}
