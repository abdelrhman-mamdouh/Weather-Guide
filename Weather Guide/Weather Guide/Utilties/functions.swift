//
//  functions.swift
//  Weather Guide
//
//  Created by Abdelrhman Mamdouh on 18/05/2024.
//

import Foundation
import SwiftUI


func filterForecast(_ forecast: [Hour]) -> [Hour] {
    let currentTime = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    let calendar = Calendar.current
    
    return forecast.filter { hour in
        if let date = formatter.date(from: hour.time) {
           
            return date >= currentTime || calendar.compare(date, to: currentTime, toGranularity: .hour) == .orderedSame
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
        
        let inputHour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: currentTime)
        
        if inputHour == currentHour && calendar.isDate(date, inSameDayAs: currentTime) {
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
