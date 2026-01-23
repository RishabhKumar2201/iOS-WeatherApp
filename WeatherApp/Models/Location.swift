//
//  Location.swift
//  WeatherApp
//
//  Created by rentamac on 1/23/26.
//

import Foundation

struct Location: Identifiable {
    let id: UUID = UUID()
    let name: String
    let weather: Weather
    let temperature: Temperature
    
}

enum Weather {
    case sunny
    case foggy
    case snow
    case rainy
    case windy
    
    var icon: String {
        switch self {
        case .sunny: return "sun.max.fill"
        case .foggy: return "cloud.fog.fill"
        case .snow: return "snowflake"
        case .rainy: return "cloud.rain.fill"
        case .windy: return "wind"
        }
    }
}

struct Temperature {
    let min: Int
    let max: Int
    
    var temperatureText: String {
        "\(min) °C/ \(max) °C"
    }
}
