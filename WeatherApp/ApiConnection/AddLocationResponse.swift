//
//  AddLocationResponse.swift
//  WeatherApp
//
//  Created by rentamac on 1/30/26.
//

import Foundation

// MARK: - Welcome
struct AddLocationResponse: Codable {
    let results: [Result]
    let generationtimeMS: Double

    enum CodingKeys: String, CodingKey {
        case results
        case generationtimeMS = "generationtime_ms"
    }
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let name: String
    let latitude, longitude: Double
    let elevation: Int
    let featureCode, countryCode: String
    let admin1ID, admin2ID, admin3ID: Int
    let timezone: String
    let population, countryID: Int
    let country, admin1, admin2, admin3: String

    enum CodingKeys: String, CodingKey {
        case id, name, latitude, longitude, elevation
        case featureCode = "feature_code"
        case countryCode = "country_code"
        case admin1ID = "admin1_id"
        case admin2ID = "admin2_id"
        case admin3ID = "admin3_id"
        case timezone, population
        case countryID = "country_id"
        case country, admin1, admin2, admin3
    }
}

extension AddLocationResponse {
    
    var firstCoordinate: (latitude: Double, longitude: Double)? {
        guard let first = results.first else { return nil }
        return (first.latitude, first.longitude)
    }
}
