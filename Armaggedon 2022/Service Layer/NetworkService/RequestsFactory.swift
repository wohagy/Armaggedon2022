//
//  RequestsFactory.swift
//  Armaggedon 2022
//
//  Created by Macbook on 29.04.2022.
//

import Foundation

struct RequestsFactory {
    struct AsteroidsConfig {
        static func asteroidsConfig(startDay: Date, endDay: Date) -> RequestConfig<AsteroidsParser> {
            return RequestConfig<AsteroidsParser>(request: AsteroidsRequest(startDay: startDay, endDay: endDay), parser: AsteroidsParser())
        }
    }
}
