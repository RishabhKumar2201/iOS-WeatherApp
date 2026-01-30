//
//  WeatherEndpoint.swift
//  WeatherApp
//
//  Created by rentamac on 1/27/26.
//

import Foundation

struct WeatherEndpoint : ApiEndpoint {
    
    var request: WeatherRequest
    
    var baseURL: String {
        "https://\(FetchingAPI.baseURL)"
//        "https://api.open-meteo.com"
    }
    
    var path: String {
        FetchingAPI.path
//        "/v1/forecast"
    }
    
    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "latitude", value: "\(request.latitude)"),
            URLQueryItem(name: "longitude", value: "\(request.longitude)"),
            URLQueryItem(name: "current", value: "temperature_2m,relative_humidity_2m,wind_speed_10m,cloud_cover,wind_direction_10m,weather_code")      
        ]
    }
}
