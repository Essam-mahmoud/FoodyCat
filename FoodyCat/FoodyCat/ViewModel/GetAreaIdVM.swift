//
//  GetAreaIdVM.swift
//  FoodyCat
//
//  Created by Essam Orabi on 15/01/2022.
//

import Foundation

class GetAreaIdVM: ViewModel {
    var areaResult: GetAreaIdModel?

    func getAreaId(long: Double, lat: Double, onComplete: @escaping(_ errorMessage : String?,_ ErrorResponse:ResponseModel?, _ state:State)->()) {
        let params = ["lat":lat,
                      "lng":long
        ] as [String : Any]
        let url = AppConstant.UrlHandler.getAreaId
        let  encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let resource = Resource<GetAreaIdModel>(url: encodedUrl,httpMethod:.get,parameters:params, header:SharedData.SharedInstans.getHeader())
        HttpApiCallingWithRep.requestWithBody(resource: resource) { (Result, StatusCode, Mesg, errorResponse) in
            if StatusCode == 200 {
                if let feeds = Result{
                    self.areaResult = feeds
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
