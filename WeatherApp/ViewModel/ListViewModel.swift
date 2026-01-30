import Foundation
internal import Combine

@MainActor
final class ListViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var locations: [Location] = [
        Location(name: "Mumbai", weather: .sunny, temperature: Temperature(min: 0, max: 24), latitude: 18.9582, longitude: 72.8358),
        Location(name: "New Delhi", weather: .foggy, temperature: Temperature(min: 11, max: 15), latitude: 28.6139, longitude: 77.2090),
        Location(name: "Chennai", weather: .sunny, temperature: Temperature(min: 25, max: 28), latitude: 13.0843, longitude: 80.2707),
        Location(name: "Bengaluru", weather: .sunny, temperature: Temperature(min: 5, max: 9), latitude: 12.9629, longitude: 77.5775)
    ]
    
    private let weatherService: WeatherServiceProtocol
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }
    
    var filteredLocations: [Location] {
        searchText.isEmpty
        ? locations
        : locations.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    func addLocation(name: String) async {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }
        
        let alreadyExists = locations.contains {
            $0.name.caseInsensitiveCompare(trimmedName) == .orderedSame
        }
        
        if alreadyExists {
            print("Location already exists:", trimmedName)
            return
        }
        
        do {
            // Fetch coordinates
            let response = try await weatherService.fetchLocation(name: trimmedName)
            
            guard let coordinate = response.firstCoordinate else {
                print("No coordinates found for:", trimmedName)
                return
            }
            
            let latitude = coordinate.latitude
            let longitude = coordinate.longitude
            
            let persistence = PersistenceController.shared
            
            // Check Core Data
            if let cached = persistence.fetchCachedWeather(
                latitude: latitude,
                longitude: longitude
            ) {
                print("Weather already cached in Core Data")
            } else {
                // Fetch weather from API
                print("Fetching weather from API")
                
                let weather = try await weatherService.fetchWeather(
                    latitude: latitude,
                    longitude: longitude
                )
                
                // Save to Core Data
                let tempLocation = Location(
                    name: trimmedName,
                    weather: .sunny,
                    temperature: Temperature(min: 0, max: 0),
                    latitude: latitude,
                    longitude: longitude
                )
                
                persistence.saveWeather(
                    location: tempLocation,
                    weather: weather
                )
            }
            
            // Add to locations array
            let newLocation = Location(
                name: trimmedName,
                weather: .sunny,
                temperature: Temperature(min: 0, max: 0),
                latitude: latitude,
                longitude: longitude
            )
            
            locations.append(newLocation)
            print("Location added:", trimmedName)
            
        } catch {
            print("Failed to add location:", error)
        }
    }

}
