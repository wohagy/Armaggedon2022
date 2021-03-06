//
//  Logger.swift
//  Armaggedon 2022
//
//  Created by Macbook on 29.04.2022.
//

import Foundation

final class Logger {
    static let shared = Logger()
    private init() {}
    
    func message(_ message: String) {
        #if DEBUG
        print(message)
        #endif
    }
    
    func messageWithObject(message: String, object: Any) {
        #if DEBUG
        print(message, "\n", object)
        #endif
    }
}
