//
//  Request.swift
//  iOS Chat
//
//  Created by Macbook on 25.04.2022.
//

import Foundation

struct RequestConfig<Parser> where Parser: ParserProtocol {
    let request: RequestProtocol
    let parser: Parser
}
