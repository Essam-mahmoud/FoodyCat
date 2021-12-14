//
//  Alias.swift
//  etajer
//
//  Created by mohamed on 12/17/18.
//  Copyright © 2018 mohamed. All rights reserved.
//

import Foundation
import UIKit

public typealias JSONAlis = [String: Any]
public typealias HTTcPHeaders = [String: String]
public typealias ImagePickerBlock = (UIImage?) -> Void
public typealias DatePickerBlock = (Date?) -> Void
public typealias StringBlock = (String?) -> Void
public typealias FloatBlock = (CGFloat?) -> Void
public typealias IntBlock = (Int?) -> Void
public typealias ResultCompletionHandler = (JSONAlis?) -> ()
public typealias ActionBlock = () -> Void
public typealias SuccessActionBlock = (Bool) -> ()
//typealias ItemSelectBlock = (ListItem?) -> ()


