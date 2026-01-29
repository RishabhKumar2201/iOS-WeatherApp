//
//  PersistenceController.swift
//  WeatherApp
//
//  Created by rentamac on 1/29/26.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "weatherInfoOfLocation")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Core Data error \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        print("Core Data loaded successfully...")
    }
}

extension PersistenceController {
    
    func saveWeather(
        location: Location,
        weather: WeatherResponse
    ) {
        let context = container.viewContext
        
        let fetch: NSFetchRequest<Locations> = Locations.fetchRequest()
        fetch.predicate = NSPredicate(
            format: "latitude == %lf AND longitude == %lf",
            location.latitude,
            location.longitude
        )
        
        let entity = (try? context.fetch(fetch).first) ?? Locations(context: context)
        
        entity.name = location.name
        entity.latitude = location.latitude
        entity.longitude = location.longitude
        
        entity.temperature2M = weather.current.temperature2M
        entity.windSpeed10M = weather.current.windSpeed10M
        entity.windDirection10M = Int16(weather.current.windDirection10M)
        entity.cloudCover = Int16(weather.current.cloudCover)
        entity.relativeHumidity2M = Int16(weather.current.relativeHumidity2M)
        entity.weatherCode = Int16(weather.current.weatherCode)
        
        entity.updatedTime = Date()
        print("SAVING WEATHER TO CORE DATA")

        try? context.save()
    }
}

extension PersistenceController {
    
//    func fetchCachedWeather(
//        latitude: Double,
//        longitude: Double
//    ) -> Locations? {
//        
//        let context = container.viewContext
//        let request: NSFetchRequest<Locations> = Locations.fetchRequest()
//        
//        request.predicate = NSPredicate(
//            format: "latitude == %lf AND longitude == %lf",
//            latitude,
//            longitude
//        )
//        
//        return try? context.fetch(request).first
//    }
    
    func fetchCachedWeather(
        latitude: Double,
        longitude: Double
    ) -> Locations? {
        
        let context = container.viewContext
        let request: NSFetchRequest<Locations> = Locations.fetchRequest()
        
        request.predicate = NSPredicate(
            format: "latitude == %lf AND longitude == %lf",
            latitude,
            longitude
        )
        
        let result = try? context.fetch(request).first
        
        if result != nil {
            print("CORE DATA HIT for \(latitude), \(longitude)")
        }
        
        return result
    }

}

extension PersistenceController {
    
    func isCacheValid(_ location: Locations) -> Bool {
        guard let updated = location.updatedTime else { return false }
        return Date().timeIntervalSince(updated) < 60
    }
}
