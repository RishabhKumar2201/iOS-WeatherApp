//
//  AddLocationEndpoint.swift
//  WeatherApp
//
//  Created by rentamac on 1/30/26.
//

import Foundation

struct AddLocationEndpoint: ApiEndpoint {

    var request: addLocation
    
    var baseURL: String {
        "https://\(FetchingAPI.addURL)"
    }
    
    var path: String {
        FetchingAPI.addpath
    }
    
    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "name", value: "\(request.name)"),
            URLQueryItem(name: "count", value: "\(1)")
        ]
    }
}
