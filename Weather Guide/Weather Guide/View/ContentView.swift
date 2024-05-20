//
//  ContentView.swift
//  Weather Guide
//
//  Created by Abdelrhman Mamdouh on 17/05/2024.
//

import SwiftUI
import Alamofire
import CoreLocation

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var query: String = ""
    @State private var textFieldHeight: CGFloat = 15
    @ObservedObject private var locationManager = LocationManager()
    @State private var isDay: Bool = isDayTime()
    var body: some View {
        
        Group {
            if viewModel.isLoading {
                ZStack {
                   
                    LottieView(animationName: "LoaderWeather",width: 150,height: 150)
                        .scaleEffect(2, anchor: .center)
                }.background(
                    (isDay ? Image("Day") : Image("Night"))
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                )
                .accentColor(.white)
            }else {
                NavigationView {
                    ScrollView{
                        VStack {
                            Spacer()
                            if let weather = viewModel.weatherResponse {
                                Spacer()
                                WeatherDetailView(weather: weather)
                                Spacer()
                                ThreeDayForecastView(threeDayForecast: weather.forecast.forecastday).frame(height: 320)
                                GridView(weather: weather)
                
                                
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .preferredColorScheme(isDay ? .light : .dark
                        )
                        .background(
                           (isDay ? Image("Day") : Image("Night"))
                               .scaledToFill()
                               .edgesIgnoringSafeArea(.all)
                       )
                    
                    
                }.refreshable{
                    locationManager.requestLocation()
                    if let location = locationManager.location {
                               Task {
                                   await viewModel.fetchWeather(for: location.coordinate.latitude, longitude: location.coordinate.longitude)
                               }
                           } else {
                               print("Location not available")
                           }
                }
            }
                
            }
                .onAppear {
                    locationManager.requestLocation()
                    if let location = locationManager.location {
                        Task {
                            await viewModel.fetchWeather(for: location.coordinate.latitude, longitude: location.coordinate.longitude)
                            withAnimation {
                                textFieldHeight = 15
                            }
                        }
                    } else {
                        print("Location not available")
                    }
                }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
