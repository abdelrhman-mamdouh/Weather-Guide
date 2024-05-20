//
//  HourlyForecastView.swift
//  Weather Guide
//
//  Created by Abdelrhman Mamdouh on 18/05/2024.
//

import SwiftUI
import Kingfisher
struct HourlyForecastView: View {
    var hourlyForecast: [Hour]
    @State private var isDay: Bool = isDayTime()
    
    var body: some View {
        let filteredForecast = filterForecast(hourlyForecast)
        ScrollView{
            VStack {
                ForEach(filteredForecast) { forecast in
                    HStack {
                        Spacer()
                        Text("\(getShortTime(time: forecast.time))")
                            .font(.system(size: 25))
                            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                        Spacer()
                        KFImage(URL(string: "https:\(forecast.condition.icon)"))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 50, maxHeight: 50)
                            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                        Spacer()
                        Text("\(Int(forecast.temp_c))°C")
                            .font(.system(size: 25))
                            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                    } .background(Color.white.blur(radius: 100).opacity(0.5))
                    
                    .cornerRadius(15)
                }
            }.padding(50)
           
        } .background(
            (isDay ? Image("Day") : Image("Night"))
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)
        )
    }
    
}
#Preview {
    HourlyForecastView(hourlyForecast: [Hour.example])
                   .background(Color.blue)
}
