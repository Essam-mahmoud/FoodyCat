//
//  HomeVM.swift
//  FoodyCat
//
//  Created by Essam Orabi on 12/12/2021.
//

import Foundation

class HomeVM: ViewModel {
    var celeberitiesModel: CeleberitiesModel?
    var bannerModel: BannerModel?

    func getCeleberities(pageNumber: Int, onComplete: @escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {
        let params = ["page":pageNumber] as [String : Any]
        let url = AppConstant.UrlHandler.getCelebrities
        let  encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let resource = Resource<CeleberitiesModel>(url: encodedUrl,httpMethod:.get,parameters:params, header:SharedData.SharedInstans.getHeader())
        HttpApiCallingWithRep.requestWithBody(resource: resource) { (Result, StatusCode, Mesg, errorResponse) in
            if StatusCode == 200 {
                if let feeds = Result{
                    self.celeberitiesModel = feeds
                    onComplete(nil, nil, .populated)
                } else {
                    onComplete(Mesg, errorResponse, .error)
                }
            } else {
                onComplete(Mesg, errorResponse, .error)
            }
        }
    }

    func getBannarData(type: Int, areaId: Int, onComplete: @escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {
        let params = ["areaid": areaId] as [String : Any]
        let url = AppConstant.UrlHandler.getBanners + "\(type)"
        let  encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let resource = Resource<BannerModel>(url: encodedUrl,httpMethod:.get,parameters:params, header:SharedData.SharedInstans.getHeader())
        HttpApiCallingWithRep.requestWithBody(resource: resource) { (Result, StatusCode, Mesg, errorResponse) in
            if StatusCode == 200 {
                if let feeds = Result{
                    self.bannerModel = feeds
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
