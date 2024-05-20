//
//  WeatherDetailView.swift
//  Weather Guide
//
//  Created by Abdelrhman Mamdouh on 18/05/2024.
//

import SwiftUI
import Kingfisher

struct WeatherDetailView: View {
    var weather: WeatherResponse
    
    var body: some View {
        VStack {
            Text(weather.location.name)
                .font(.system(size: 30, weight: .bold))
                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                .padding(.bottom, 1)
            Text("\(Date().formatted(date: .complete, time: .omitted))")
                .font(.system(size: 16))
             
                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
            KFImage(URL(string: "https:\(weather.forecast.forecastday[0].day.condition.icon)"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 100, maxHeight: 100)
                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
         
                
            Text("\(weather.forecast.forecastday[0].day.avgtemp_c, specifier: "%.1f")°C")
                .font(.system(size: 50))
            
                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
            Text(weather.current.condition.text)
                .font(.system(size: 18))
               
                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
            Text("H: \(Int(weather.forecast.forecastday[0].day.maxtemp_c))° L: \(Int(weather.forecast.forecastday[0].day.mintemp_c))")
                .font(.system(size: 17))
              
                .bold()
                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                .padding(.top, 12)
        }
    }
}
  
#Preview {
    WeatherDetailView(weather: WeatherResponse.example)
}
   
