//
//  helper.swift
//  WeatherApp
//
//  Created by rentamac on 1/29/26.
//

extension Locations {
    
    func toWeatherResponse() -> WeatherResponse {
        WeatherResponse(
            latitude: latitude,
            longitude: longitude,
            generationtimeMS: 0,
            utcOffsetSeconds: 0,
            timezone: "",
            timezoneAbbreviation: "",
            elevation: 0,
            currentUnits: CurrentUnits(
                time: "",
                interval: "",
                temperature2M: "°C",
                relativeHumidity2M: "%",
                windSpeed10M: "km/h",
                cloudCover: "%",
                windDirection10M: "°",
                weatherCode: ""
            ),
            current: Current(
                time: "",
                interval: 0,
                temperature2M: temperature2M,
                relativeHumidity2M: Int(relativeHumidity2M),
                windSpeed10M: windSpeed10M,
                cloudCover: Int(cloudCover),
                windDirection10M: Int(windDirection10M),
                weatherCode: Int(weatherCode)
            )
        )
    }
}

