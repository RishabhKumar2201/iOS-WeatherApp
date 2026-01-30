//
//  WeatherService.swift
//  WeatherApp
//
//  Created by rentamac on 1/27/26.
//

import Foundation

//protocol WeatherServiceProtocol {
//    func fetchWeather(latitude: Double, longitude: Double)
//    async throws -> WeatherResponse
//}

protocol WeatherServiceProtocol {
    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse
    func fetchLocation(name: String) async throws -> AddLocationResponse
}


final class WeatherService: WeatherServiceProtocol {
    private let networkService: Networking
    
    init(networkService: Networking) {
        self.networkService = networkService
    }
    
    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse {
        
        print("\(FetchingAPI.baseURL)")
        
        let request = WeatherRequest(latitude: latitude, longitude: longitude)
        
        let endpoint = WeatherEndpoint(request: request)
        
        return try await networkService.request(endpoint: endpoint, responseType: WeatherResponse.self)
    }
    
    func fetchLocation(name: String) async throws -> AddLocationResponse {
        
        print("\(FetchingAPI.baseURL)")
        
        let request = addLocation(name: name)
        
        let endpoint = AddLocationEndpoint(request: request)
        
        return try await networkService.request(endpoint: endpoint, responseType: AddLocationResponse.self)
    }
}
