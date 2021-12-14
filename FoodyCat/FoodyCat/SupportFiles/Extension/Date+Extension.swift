//
//  Date+Extension.swift
//  Baraa Captain
//
//  Created by User on 10/8/20.
//  Copyright © 2020 taha hamdi. All rights reserved.
//

import Foundation

extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}

extension Date {
    
    var nextday: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var nextWeek: Date {
        return Calendar.current.date(byAdding: .day, value: 7, to: self)!
    }
    
    var lastWeek: Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: self)!
    }
    
    func startOfWeek(using calendar: Calendar = .gregorian) -> Date {
        let date = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        return calendar.date(byAdding: .day, value: -1, to: date)!
    }
    
    func endOfWeek(using calendar: Calendar = .gregorian) -> Date {
        let date = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        return calendar.date(byAdding: .day, value: 5, to: date)!
    }
    
    func toSendApiFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.string(from: self)
    }
    
    func toStringFormat() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    func toDayNameFormat() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self)
    }
    
    func toDayNumberFormat() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }
}


extension String {
    private static let formatter = NumberFormatter()

    func clippingCharacters(in characterSet: CharacterSet) -> String {
        components(separatedBy: characterSet).joined()
    }

    func convertedDigitsToLocale(_ locale: Locale = .current) -> String {
        let digits = Set(clippingCharacters(in: CharacterSet.decimalDigits.inverted))
        guard !digits.isEmpty else { return self }

        Self.formatter.locale = locale

        let maps: [(original: String, converted: String)] = digits.map {
            let original = String($0)
            let digit = Self.formatter.number(from: original)!
            let localized = Self.formatter.string(from: digit)!
            return (original, localized)
        }

        return maps.reduce(self) { converted, map in
            converted.replacingOccurrences(of: map.original, with: map.converted)
        }
    }
}
