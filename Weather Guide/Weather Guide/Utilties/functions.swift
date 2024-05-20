//
//  functions.swift
//  Weather Guide
//
//  Created by Abdelrhman Mamdouh on 18/05/2024.
//

import Foundation
import SwiftUI

func getWeatherEmoji(code: Int) -> String {
    switch code {
    case 1000:
        return "☀️"
    case 1003:
        return "⛅️"
    case 1006, 1009:
        return "☁️"
    case 1030, 1135, 1147:
        return "🌫"
    case 1063, 1180, 1183, 1186, 1189, 1192, 1195, 1240, 1243, 1246:
        return "🌧"
    case 1066, 1069, 1072, 1114, 1117, 1210, 1213, 1216, 1219, 1222, 1225, 1255, 1258:
        return "❄️"
    case 1087, 1273, 1276, 1279, 1282:
        return "⛈"
    default:
        return "❓"
    }
}

func filterForecast(_ forecast: [Hour]) -> [Hour] {
    let currentTime = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    
    return forecast.filter { hour in
        if let date = formatter.date(from: hour.time) {
            return date >= currentTime
        }
        return false
    }
}


func getShortTime(time: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    if let date = formatter.date(from: time) {
        let currentTime = Date()
        let calendar = Calendar.current
        if calendar.compare(date, to: currentTime, toGranularity: .hour) == .orderedSame {
            return "Now"
        } else {
            formatter.dateFormat = "h a"
            return formatter.string(from: date)
        }
    }
    return time
}



func getShortDayName(epoch: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(epoch))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE"
    
    let calendar = Calendar.current
    if calendar.isDateInToday(date) {
        return "Today"
    } else {
        return dateFormatter.string(from: date)
    }
}
func getShortDate(epoch: Int) -> String {
   
    let date = Date(timeIntervalSince1970: TimeInterval(epoch))
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE, d MMM"
    return formatter.string(from: date)
}
func getCurrentHour() -> Int {
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    return hour
}

func isDayTime() -> Bool {
    let hour = getCurrentHour()
    return (hour >= 6 && hour < 18)
}
