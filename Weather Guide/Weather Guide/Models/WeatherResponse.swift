//
//  WeatherResponse.swift
//  Weather Guide
//
//  Created by Abdelrhman Mamdouh on 18/05/2024.
//

import Foundation
struct WeatherResponse: Codable {
    var location: Location
    var forecast: Forecast
    var current : Current
    
    static var example: WeatherResponse {
        return WeatherResponse(
            location: Location(name: "New York"),
            forecast: Forecast(
                forecastday: [ForecastDay.example]
            ),
            current: Current.example
        )
    }
}

struct Location: Codable {
    var name: String
}
struct Current: Codable {
    var temp_c: Double
    var is_day: Int
    var condition: Condition
    var humidity: Int
    var feelslike_c: Double
    var vis_km: Double
    var pressure_mb: Double
    static var example: Current {
            Current(
                temp_c: 25.0,
                is_day: 1,
                condition: Condition(text: "Partly cloudy",icon:"dasd", code: 1000),
                humidity: 60,
                feelslike_c: 27.0,
                vis_km: 10.0,
                pressure_mb: 1013.0
            )
        }
    
}

struct Forecast: Codable {
    var forecastday: [ForecastDay]
}


struct ForecastDay: Codable, Identifiable {
    var date_epoch: Int
    var day: Day
    var hour: [Hour]
    var id: Int { date_epoch }
    
    static var example: ForecastDay {
        return ForecastDay(
            date_epoch: 1621339200,
            day: Day(
                maxtemp_c: 13.0,
                mintemp_c: 20.0,
                avgtemp_c: 25.0,
                maxwind_kph: 20.0,
                totalprecip_mm: 2.5,
                daily_chance_of_rain: 30,
                avghumidity: 60,
                uv: 5.0,
                avgvis_km: 10.0,
                condition: Condition(text: "Partly cloudy",icon: "das", code: 1000)
            ),
            hour: [Hour.example]
        )
    }
}

struct Day: Codable {
    var maxtemp_c: Double 
    var mintemp_c: Double
    var avgtemp_c: Double
    var maxwind_kph: Double
    var totalprecip_mm: Double
    var daily_chance_of_rain: Int
    var avghumidity: Int
    var uv: Double
    var avgvis_km: Double
    var condition: Condition
}

struct Condition: Codable {
    var text: String
    var icon: String
    var code: Int
}

struct Hour: Codable, Identifiable {
    var time_epoch: Int
    var time: String
    var temp_c: Double
    var condition: Condition
    var feelslike_c: Double
    var id: Int { time_epoch }
    
    static var example: Hour {
        return Hour(
            time_epoch: 1621339200,
            time: "12:00 PM",
            temp_c: 25.0,
            condition: Condition(text: "Sunny", icon: "sda", code: 1000),
            feelslike_c: 26.0
        )
    }
}
