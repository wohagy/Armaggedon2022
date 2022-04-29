//
//  Date + DateFormatter.swift
//  Armaggedon 2022
//
//  Created by Macbook on 29.04.2022.
//

import Foundation

extension Date {
    
    func stringFromDate(dateFormat: String) -> String {
        let formatter = DateFormatter.customFormatter(with: dateFormat)
        return formatter.string(from: self)
    }
}

extension DateFormatter {
    
    static func customFormatter(with format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = .current
        return formatter
    }
}
