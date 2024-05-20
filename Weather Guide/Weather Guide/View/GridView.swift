//
//  GridView.swift
//  Weather Guide
//
//  Created by Abdelrhman Mamdouh on 19/05/2024.
//

import SwiftUI

struct GridView: View {
    var weather: WeatherResponse
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
     
            LazyVGrid(columns: columns, spacing: 20) {
                VStack {
                    Spacer()
                    Text("Visibility")
                    Spacer()
                    Text("\(Int(weather.current.vis_km)) km")
                        .font(.system(size: 30, weight: .bold))
                    Spacer()
                }
                .frame(width: 150, height: 150)
                .background(Color.white.blur(radius: 100).opacity(0.5))
                .cornerRadius(10)
                .padding(5)
                
                VStack {
                    Spacer()
                    Text("Humidity")
                    Spacer()
                    Text("\(Int(weather.current.humidity)) %")
                        .font(.system(size: 30, weight: .bold))
                    Spacer()
                }
                .frame(width: 150, height: 150)
                .background(Color.white.blur(radius: 100).opacity(0.5))
                .cornerRadius(10)
                .padding(5)
                
                VStack {
                    Spacer()
                    Text("Feels Like")
                    Spacer()
                    Text("\(Int(weather.current.feelslike_c))°")
                        .font(.system(size: 30, weight: .bold))
                    Spacer()
                }
                .frame(width: 150, height: 150)
                .background(Color.white.blur(radius: 100).opacity(0.5))
                .cornerRadius(10)
                .padding(5)
                
                VStack {
                    Spacer()
                    Text("Pressure")
                    Spacer()
                    Text("\(Int(weather.current.pressure_mb))")
                        .font(.system(size: 30, weight: .bold))
                    Spacer()
                }
                .frame(width: 150, height: 150)
                .background(Color.white.blur(radius: 100).opacity(0.5))
                .cornerRadius(10)
                .padding(5)
            }
            .scrollDisabled(true)
            .contentMargins(.vertical,0)
            .scrollContentBackground(.hidden)
            .preferredColorScheme(.dark)
            .padding(.horizontal, 20)        }
    }


#Preview {
    GridView(weather: WeatherResponse.example)
}

