import SwiftUI

struct DetailView: View {
    let location: Location
    @State private var weatherResponse: WeatherResponse?
    @State private var isLoading = false
    @State private var error: Error?
    
    let weatherService: WeatherServiceProtocol
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("backgroundColor", bundle: nil).ignoresSafeArea()
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else if let error = error {
                    Text("Error: \(error.localizedDescription)")
                        .foregroundColor(.white)
                } else if let weather = weatherResponse {
                    realTimeWeatherView(weather: weather)
                } else {
                    originalStaticView()
                }
            }
            .navigationTitle(location.name)
            .task {
                await fetchWeather()
            }
        }
    }
    
    private func fetchWeather() async {
        isLoading = true
        error = nil
        do {
            weatherResponse = try await weatherService.fetchWeather(
                latitude: location.latitude,
                longitude: location.longitude
            )
        } catch {
            self.error = error
        }
        isLoading = false
    }
    
    // Keep original view as fallback
    private func originalStaticView() -> some View {
        VStack {
            Image(systemName: location.weather.icon)
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundStyle(.yellow)
            
            Text(location.temperature.temperatureText)
                .font(.title)
                .foregroundStyle(.gray)
            
            Spacer()
            
            HStack {
                Text("A warm breeze drifted through the streets...")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding()
            }
            Spacer()
        }
    }
    
    private func realTimeWeatherView(weather: WeatherResponse) -> some View {
        VStack {
            Image(systemName: weatherCodeToIcon(weather.current.weatherCode))
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundStyle(.yellow)
            
            Text("\(Int(weather.current.temperature2M)) °C")
                .font(.largeTitle)
                .foregroundStyle(.white)
            
            Text("Feels like real-time weather")
                .font(.title2)
                .foregroundStyle(.gray)
            
            Spacer()
        }
    }
    
    private func weatherCodeToIcon(_ code: Int) -> String {
        // Map Open-Meteo weather codes to SF Symbols
        switch code {
        case 0, 1, 2, 3: return "sun.max.fill"  // Clear
        case 45, 48: return "cloud.fog.fill"    // Fog
        case 61, 63, 65: return "cloud.rain.fill"
        case 71, 73, 75, 77, 85, 86: return "snowflake"
        case 95...99: return "cloud.bolt.fill"
        default: return "cloud.fill"
        }
    }
}
