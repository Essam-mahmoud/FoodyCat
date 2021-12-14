//
//  ForgetPasswordVM.swift
//  FoodyCat
//
//  Created by Essam Orabi on 11/12/2021.
//

import Foundation

class ForgetPasswordVM: ViewModel {
    var result: ResponseModel?

    func forgetPassword( email: String, onComplete:@escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {

        let params = ["email":email] as [String : Any]

        let resource = Resource<ResponseModel>(url:AppConstant.UrlHandler.forgetPassword,httpMethod:.post,parameters:params, header: AppCommon.sharedInstance.getHeader(AddtionParms: [:]))

        HttpApiCallingWithRep.requestWithBody(resource: resource){
            (Result, StatusCode, Mesg ,errorResponse) in
            if StatusCode == 200 {
                if let Data = Result {
                    //SharedData.SharedInstans.settoken( Data.token ??  "")
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
