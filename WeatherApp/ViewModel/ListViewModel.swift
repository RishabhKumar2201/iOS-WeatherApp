//
//  ListViewModel.swift
//  WeatherApp
//
//  Created by rentamac on 1/23/26.
//

import Foundation
import SwiftUI
internal import Combine

final class ListViewModel: ObservableObject {
    @Published var searchText: String = ""
    
    @Published var locations: [Location] = [
        Location(name: "Mumbai", weather: .sunny, temperature: Temperature(min: 0, max: 24), latitude: 18.9582, longitude: 72.8358),
        Location(name: "New Delhi", weather: .foggy, temperature: Temperature(min: 11, max: 15), latitude: 28.6139, longitude: 77.2090),
        Location(name: "Chennai", weather: .sunny, temperature: Temperature(min: 25, max: 28), latitude: 13.0843, longitude: 80.2707),
        Location(name: "Bengaluru", weather: .sunny, temperature: Temperature(min: 5, max: 9), latitude: 12.9629, longitude: 77.5775),
        Location(name: "Gurgaon", weather: .rainy, temperature: Temperature(min: 10, max: 13), latitude: 28.4595, longitude: 77.0266),
        Location(name: "Noida", weather: .foggy, temperature: Temperature(min: 8, max: 9), latitude: 28.5355, longitude: 77.3910),
        Location(name: "Hyderabad", weather: .snow, temperature: Temperature(min: 25, max: 29), latitude: 17.4065,   longitude: 78.4772),
        Location(name: "Ahmedabad", weather: .windy, temperature: Temperature(min: 30, max: 33), latitude: 23.0225,      longitude: 72.5714),
        Location(name: "Indore", weather: .sunny, temperature: Temperature(min: 19, max: 21), latitude: 22.7196,      longitude: 75.8577)
    ]
    
    var filteredLocations: [Location] {
        if searchText.isEmpty {
            return locations
        } else {
            return locations.filter({
                $0.name.localizedCaseInsensitiveContains(searchText)
            })
        }
    }
}
