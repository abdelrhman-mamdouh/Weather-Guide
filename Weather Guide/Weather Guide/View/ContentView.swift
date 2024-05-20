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
    var body: some View {
            Group {
                if viewModel.isLoading {
                    ZStack {
                        Color.blue
                            .ignoresSafeArea()
                        ProgressView()
                            .scaleEffect(2, anchor: .center)
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    }
                } else {
                    NavigationView {
                        VStack {
                            Spacer()

                            if let location = locationManager.location {
                                Text("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
                                    .padding()
                            } else {
                                Text("Fetching location...")
                                    .padding()
                            }

                            TextField("Enter city name or postal code", text: $query, onEditingChanged: { focused in
                                withAnimation {
                                    textFieldHeight = 130
                                }
                            })
                            .textFieldStyle(PlainTextFieldStyle())
                            .background(
                                Rectangle()
                                    .foregroundColor(.white.opacity(0.2))
                                    .cornerRadius(25)
                                    .frame(height: 50)
                            )
                            .padding(.horizontal, 40)
                            .padding(.bottom, 15)
                            .padding(.top, textFieldHeight)
                            .multilineTextAlignment(.center)
                            .accentColor(.white)
                            .font(Font.system(size: 20, design: .default))
                            .onSubmit {
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

                        if let weather = viewModel.weatherResponse {
                            VStack {
                                Text(weather.location.name)
                                    .font(.system(size: 35))
                                    .foregroundColor(.white)
                                    .bold()
                                    .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                    .padding(.bottom, 1)
                                Text("\(Date().formatted(date: .complete, time: .omitted))")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                Text(getWeatherEmoji(code: weather.forecast.forecastday[0].day.condition.code))
                                    .font(.system(size: 110))
                                    .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                Text("\(weather.forecast.forecastday[0].day.avgtemp_c, specifier: "%.1f")°C")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                                    .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                Text(weather.forecast.forecastday[0].day.condition.text)
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                    .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                            }

                            Spacer()

                            Text("Hourly Forecast")
                                .font(.system(size: 17))
                                .foregroundColor(.white)
                                .bold()
                                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    Spacer()
                                    ForEach(weather.forecast.forecastday[0].hour) { forecast in
                                        VStack {
                                            Text("\(getShortTime(time: forecast.time))")
                                                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                            Text("\(getWeatherEmoji(code: forecast.condition.code))")
                                                .frame(width: 50, height: 14)
                                                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                            Text("\(Int(forecast.temp_c))°C")
                                                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                        }
                                        .frame(width: 50, height: 90)
                                    }
                                    Spacer()
                                }
                                .background(Color.white.blur(radius: 75).opacity(0.35))
                                .cornerRadius(15)
                            }
                            .padding([.top, .horizontal], 18)

                            Spacer()

                            Text("3 Day Forecast")
                                .font(.system(size: 17))
                                .foregroundColor(.white)
                                .bold()
                                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                .padding(.top, 12)

                            List {
                                ForEach(weather.forecast.forecastday) { forecast in
                                    NavigationLink {
                                        // Detail view if needed
                                    } label: {
                                        HStack(alignment: .center) {
                                            Text("\(getShortDate(epoch: forecast.date_epoch))")
                                                .frame(maxWidth: 50, alignment: .leading)
                                                .bold()
                                                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                            Text("\(getWeatherEmoji(code: forecast.day.condition.code))")
                                                .frame(maxWidth: 30, alignment: .leading)
                                                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                            Text("\(Int(forecast.day.avgtemp_c))°C")
                                                .frame(maxWidth: 50, alignment: .leading)
                                                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                            Spacer()
                                            Text("\(forecast.day.condition.text)")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                        }
                                    }
                                }
                                .listRowBackground(Color.white.blur(radius: 75).opacity(0.5))
                            }
                            .listStyle(PlainListStyle())
                            .scrollContentBackground(.hidden)
                            .preferredColorScheme(.dark)

                            Spacer()

                            Text("Data supplied by Weather API")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .background(Color.blue) // Adjust to match your desired background color
                }
                .accentColor(.white)
            }
        }
    }


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
