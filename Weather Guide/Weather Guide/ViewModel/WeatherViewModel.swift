//
//  WeatherViewModel.swift
//  Weather Guide
//
//  Created by Abdelrhman Mamdouh on 18/05/2024.
//


import Foundation
import Combine
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var weatherResponse: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let networkManager = NetworkManager()
    
    func fetchWeather(for latitude: Double, longitude: Double) {
        isLoading = true
        errorMessage = nil
        
        networkManager.fetchWeather(for: latitude, longitude: longitude) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let weatherResponse):
                    self.weatherResponse = weatherResponse
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
