//
//  String+Ex.swift
//  FoodyCat
//
//  Created by Essam Orabi on 18/12/2021.
//

import Foundation

extension String {
    //Converts String to Int
    public func toInt() -> Int {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return 0
        }
    }

    //Converts String to Double
    public func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }

    /// EZSE: Converts String to Float
    public func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }

    //Converts String to Bool
    public func toBool() -> Bool? {
        return (self as NSString).boolValue
    }
}
