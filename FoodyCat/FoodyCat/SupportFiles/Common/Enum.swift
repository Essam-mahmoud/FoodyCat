//
//  Enum.swift
//  CarWash
//
//  Created by Mohammad Farhan on 22/12/1710/11/17.
//  Copyright © 2017 CarWash. All rights reserved.
//

import Foundation


enum statusCode {
    
    static let NOT_FOUND = 404
    static let OK = 200
    static let BAD_GATEWAY = 502
    static let SERVICE_UNAVAILABLE = 500
    static let NO_CONTENT = 204
    static let ACCEPTED = 201
    static let CREATED = 0
    static let UNAuthoried = 401
    
    
}
enum validationTypes{
    case email
    case mobile
    case password
    case IDNumber
    case matchString
    case normal
    case emptyString
}
public enum State {
    case loading
    case showAlert
    case error
    case empty
    case populated
    case normal
    case refresh
}

public enum tripStatusEnum: Int{
    case onTheWay = 4
    case arrive = 5
    case start = 6
}
