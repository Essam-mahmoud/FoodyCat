//
//  NormalResponse.swift
//  DAWAA
//
//  Created by apple on 6/23/20.
//  Copyright © 2020 taha hamdi. All rights reserved.
//

import Foundation


import UIKit


class ResponseModel : Codable {
    let message : String?
    let code : Int?
    
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case code = "code"
    }
    
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        
    }
    
}



