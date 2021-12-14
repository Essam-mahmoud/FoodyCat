//
//  ViewModel.swift
//  TouchPoint
//
//  Created by Taha on 06/04/2021.
//

class ViewModel {
    var baseReponse:ResponseModel?
    var state: State = .empty
    
    var compleationHandler:()->() = {}
    var compleationHandlerWithError:()->() = {}
    var completionHandlerWithError:(_ statusCode : Int ,_ err:String )->Void = {_,_  in}
    
}
