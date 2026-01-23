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
        Location(name: "Mumbai", weather: .sunny, temperature: Temperature(min: 22, max: 24)),
        Location(name: "New Delhi", weather: .foggy, temperature: Temperature(min: 11, max: 15)),
        Location(name: "Chennai", weather: .sunny, temperature: Temperature(min: 25, max: 28)),
        Location(name: "Bengaluru", weather: .sunny, temperature: Temperature(min: 5, max: 9)),
        Location(name: "GUrgaon", weather: .rainy, temperature: Temperature(min: 10, max: 13)),
        Location(name: "Noida", weather: .foggy, temperature: Temperature(min: 8, max: 9)),
        Location(name: "Hyderabad", weather: .snow, temperature: Temperature(min: 25, max: 29)),
        Location(name: "Ahmedabad", weather: .windy, temperature: Temperature(min: 30, max: 33)),
        Location(name: "Indore", weather: .sunny, temperature: Temperature(min: 19, max: 21)),
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
