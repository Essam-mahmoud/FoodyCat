//
//  CreateAccountVM.swift
//  FoodyCat
//
//  Created by Essam Orabi on 11/12/2021.
//

import Foundation

class CreateAccountVM: ViewModel {

    var result: createAccountModel?

    func register(phone: String, email: String, name: String, password: String, datOfBirth: String, onComplete:@escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {

        let params = [
            "phone": phone,
            "email": email,
            "name": name,
            "password": password,
            "dateOfBirth": datOfBirth

        ] as [String : Any]

        let resource = Resource<createAccountModel>(url:AppConstant.UrlHandler.register,httpMethod:.post,parameters:params, header: AppCommon.sharedInstance.getHeader(AddtionParms: [:]))

        HttpApiCallingWithRep.requestWithBody(resource: resource){
            (Result, StatusCode, Mesg ,errorResponse) in
            if StatusCode == 200 {
                if let Data = Result {
                    self.result = Data
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
