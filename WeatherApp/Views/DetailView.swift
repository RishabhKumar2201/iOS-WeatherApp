import SwiftUI

struct DetailView: View {
    let location: Location
    @State private var weatherResponse: WeatherResponse?
    @State private var isLoading = false
    @State private var error: Error?
    
    @State private var timer: Timer?
    
    @State private var dataSource: WeatherDataSource?
    
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
                        .foregroundStyle(.white)
                        .padding()
                } else if let weather = weatherResponse {
                    realTimeWeatherView(weather: weather, location: location)
                    if let source = dataSource {
                        Text(source == .api ? "Live Data • API" : "Offline Data • Core Data")
                            .font(.caption)
                            .foregroundStyle(source == .api ? .green : .orange)
                    }

                } else {
                    originalStaticView(location: location)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(location.name)
                        .foregroundStyle(.white)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }
//            .navigationBarBackButtonHidden(true)
            .toolbarBackground(Color("backgroundColor"), for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
//            .task {
//                await fetchWeather()
//            }
            
            .task {
                await fetchWeather()
                
                timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
                    Task {
                        await fetchWeather()
                    }
                }
            }
            .onDisappear {
                timer?.invalidate()
            }

        }
    }
    
//    func fetchWeather() async {
//        isLoading = true
//        error = nil
//        do {
//            weatherResponse = try await weatherService.fetchWeather(
//                latitude: location.latitude,
//                longitude: location.longitude
//            )
//        } catch {
//            self.error = error
//        }
//        isLoading = false
//    }
    
//    func fetchWeather() async {
//        isLoading = true
//        error = nil
//        
//        let persistence = PersistenceController.shared
//        
//        // 1️⃣ Check Core Data first
//        if let cached = persistence.fetchCachedWeather(
//            latitude: location.latitude,
//            longitude: location.longitude
//        ),
//        persistence.isCacheValid(cached) {
//            
//            weatherResponse = cached.toWeatherResponse()
//            isLoading = false
//            return
//        }
//        
//        // 2️⃣ Fetch from API
//        do {
//            let freshWeather = try await weatherService.fetchWeather(
//                latitude: location.latitude,
//                longitude: location.longitude
//            )
//            
//            weatherResponse = freshWeather
//            
//            // 3️⃣ Save to Core Data
//            persistence.saveWeather(
//                location: location,
//                weather: freshWeather
//            )
//            
//        } catch {
//            self.error = error
//        }
//        
//        isLoading = false
//    }
    
    func fetchWeather() async {
        isLoading = true
        error = nil
        
        let persistence = PersistenceController.shared
        
        if let cached = persistence.fetchCachedWeather(
            latitude: location.latitude,
            longitude: location.longitude
        ),
        persistence.isCacheValid(cached) {
            
            print("📦 DATA FROM CORE DATA")
            weatherResponse = cached.toWeatherResponse()
            dataSource = .coreData
            isLoading = false
            return
        }
        
        do {
            print("🌐 DATA FROM API")
            let freshWeather = try await weatherService.fetchWeather(
                latitude: location.latitude,
                longitude: location.longitude
            )
            
            weatherResponse = freshWeather
            dataSource = .api
            
            persistence.saveWeather(
                location: location,
                weather: freshWeather
            )
            
        } catch {
            self.error = error
        }
        
        isLoading = false
    }


}


enum WeatherDataSource {
    case api
    case coreData
}
