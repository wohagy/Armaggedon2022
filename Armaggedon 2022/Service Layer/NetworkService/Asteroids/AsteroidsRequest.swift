//
//  AsteroidsRequest.swift
//  Armaggedon 2022
//
//  Created by Macbook on 29.04.2022.
//

import Foundation

struct AsteroidsRequest: RequestProtocol {
    var urlRequest: URLRequest? {
        let apiKey = "Uf8WSpC4T4RtLHhYLj3f1aNfjCDi3bZv3efGuaQd"
        
        var components = URLComponents()

        components.scheme = "https"
        components.host = "api.nasa.gov"
        components.path = "/neo/rest/v1/feed"

        let queryItemStartDay = URLQueryItem(name: "start_date", value: "2015-09-07")
        let queryItemEndDay = URLQueryItem(name: "end_date", value: "2015-09-08")
        let queryItemApiKey = URLQueryItem(name: "api_key", value: apiKey)

        components.queryItems = [queryItemStartDay, queryItemEndDay, queryItemApiKey]
        
        guard let url = components.url else { return nil }
        print(url)
        return URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
    }
}
