//
//  HttpApiCalling.swift
//  DAWAA
//
//  Created by apple on 6/22/20.
//  Copyright © 2020 taha hamdi. All rights reserved.
//

import Foundation

import SwiftyJSON
import NotificationBannerSwift
import Alamofire

struct Resource<T: Codable> {
    var url: String
    var httpMethod: HTTPMethod
    var parameters:Parameters
    var header:HTTPHeaders
    
}


struct ResourceWithFile<T: Codable> {
    var url: String
    var httpMethod: HTTPMethod
    var parameters:Parameters
    var header:HTTPHeaders
    var images: [String:Data]
}

class HttpApiCallingWithRep{
//    static var LoginRepoobj = LoginRepo()
    //    static var resourceobj = Resource<CustomerModel>(url:"")
    class func requestWithBody<T>
        (resource:Resource<T>, Result:@escaping(_ result :T?,_ responseCode : Int , _ errorMessage : String?,_ ErrorResponse:ResponseModel?)->()) {
        
        var EncodType : ParameterEncoding =  URLEncoding.default
        if resource.httpMethod == .get
        {
            EncodType = URLEncoding.default
        } else if resource.httpMethod == .delete
        {
            EncodType = JSONEncoding.default
        }
        else if resource.httpMethod == .post {
            EncodType = JSONEncoding.default
//                URLEncoding.default
        }
        let loadview = Loading()
        DispatchQueue.main.async {
            loadview.loading()
        }
        print(resource.url)
        

                AF.request(resource.url , method: resource.httpMethod, parameters: resource.parameters, encoding:EncodType ,headers: resource.header)
//            .validate(contentType: ["application/x-www-form-urlencoded"])
            .responseJSON { (response) in
            debugPrint(response)
            print("d",JSON(response.data as Any))
            print("r",JSON(response.result as Any))
            DispatchQueue.main.async {
                loadview.stopAnimating()
            }

            // nil response
            if response.response == nil {
                DispatchQueue.main.async {
                    //                    AppCommon.sharedInstance.showBanner(title: "Something went wrong try agen later".localized(), subtitle: "" , style: .danger)
                }
                Result(nil ,statusCode.NOT_FOUND , "Connection Error",nil)
                
                return
            }
            
            /// hvae reponse 200
            if response.response!.statusCode == statusCode.OK {
                let JSONResult = response.data
                let jsonObject = JSON(JSONResult as Any)
                
                guard let Object = CodableHandler.decodeClass(T.self, classJsonData:jsonObject)
                    as? T
                    
                    else {
                        print(Error.self)
                        return
                }
                
                Result(Object , statusCode.OK , "Success",nil)
                
                
                /// error server 500
            }else if response.response!.statusCode == statusCode.BAD_GATEWAY || response.response!.statusCode == statusCode.SERVICE_UNAVAILABLE{
                
                DispatchQueue.main.async {
                                        AppCommon.sharedInstance.showBanner(title: "Something went wrong try agen later".localized(), subtitle: "" , style: .danger)
                }
                //                Result(nil ,response.response!.statusCode , "Server Error",nil)
                
                return
            }
                
                //// custom error 401
            else if response.response!.statusCode == statusCode.UNAuthoried{
                Result(nil,response.response!.statusCode,"Unauthorized", nil)
                
            }
                
                //// custom error 400
            else{
                if let data = response.data {
                    let jsondata = JSON(data)
                    
                    guard let Object = CodableHandler.decodeClass(ResponseModel.self, classJsonData:jsondata)
                        as? ResponseModel
                        else {
                        AppCommon.sharedInstance.showBanner(title: "Something went wrong try agen later".localized(), subtitle: "" , style: .danger)
                            return
                    }
                    DispatchQueue.main.async {
                        AppCommon.sharedInstance.showBanner(title: Object.message ?? "", subtitle: "" , style: .danger)
                                             
                    }
                    
                    return
                }else{
                    AppCommon.sharedInstance.showBanner(title: "Something went wrong try agen later".localized(), subtitle: "" , style: .danger)
                    
                }
                
                
            }
        }
        
    }
    
    class func requestWithFile<T>
    (resource:ResourceWithFile<T>, Result:@escaping(_ result :T?,_ responseCode : Int , _ errorMessage : String?,_ ErrorResponse:ResponseModel?)->()) {
        let loadview = Loading()
        loadview.loading()
        print(resource.url)
        AF.upload(multipartFormData: {
            (multipartFormData) in
            for (key, value) in resource.parameters {
                if let val = value as? String {
                    multipartFormData.append(val.data(using: .utf8)!, withName: key)
                }
            }
    
            for (key, value) in resource.images ?? [:] {
                multipartFormData.append(value, withName: key, fileName: "\(key).jpeg", mimeType: "image/jpeg")
            }
            
        }, to: resource.url, method: resource.httpMethod, headers: resource.header)
            .responseData { (response) in
                debugPrint(response)
                print("d",JSON(response.data as Any))
                print("r",JSON(response.result as Any))
                loadview.stopAnimating()
                // nil response
                if response.response == nil {
                    DispatchQueue.main.async {
                        //                    AppCommon.sharedInstance.showBanner(title: "Something went wrong try agen later".localized(), subtitle: "" , style: .danger)
                    }
                    Result(nil ,statusCode.NOT_FOUND , "Connection Error",nil)
                    
                    return
                }
                
                /// hvae reponse 200
                if response.response!.statusCode == statusCode.OK {
                    let JSONResult = response.data
                    let jsonObject = JSON(JSONResult as Any)
                    
                    guard let Object = CodableHandler.decodeClass(T.self, classJsonData:jsonObject)
                        as? T
                        
                        else {
                            print("Essam")
                            //                            AppCommon.sharedInstance.showBanner(title: "Something went wrong try agen later".localized(), subtitle: "" , style: .danger)
                            
                            return
                    }
                    
                    Result(Object , statusCode.OK , "Success",nil)
                    
                    
                    /// error server 500
                }else if response.response!.statusCode == statusCode.BAD_GATEWAY || response.response!.statusCode == statusCode.SERVICE_UNAVAILABLE{
                    
                    DispatchQueue.main.async {
                        //                    AppCommon.sharedInstance.showBanner(title: "Something went wrong try agen later".localized(), subtitle: "" , style: .danger)
                    }
                    //                Result(nil ,response.response!.statusCode , "Server Error",nil)
                    
                    return
                }
                    
                    //// custom error 401
                else if response.response!.statusCode == statusCode.UNAuthoried{
                    
                    
                }
                    
                    //// custom error 400
                else{
                    if let data = response.data {
                        let jsondata = JSON(data)
                        
                        guard let Object = CodableHandler.decodeClass(ResponseModel.self, classJsonData:jsondata)
                            as? ResponseModel
                            else {
                                //                            AppCommon.sharedInstance.showBanner(title: "Something went wrong try agen later".localized(), subtitle: "" , style: .danger)
                                return
                        }
                        DispatchQueue.main.async {
                            //                        BannerView.showAlert(message:Object.message ?? "", colorCode: .failure)
                        }
                        
                        Result(nil ,400, "Error 400",Object)
                    }else{
                        
                    }
                }
        }
    }
}

