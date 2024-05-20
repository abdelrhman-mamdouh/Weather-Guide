//
//  NetworkManger.swift
//  Weather Guide
//
//  Created by Abdelrhman Mamdouh on 17/05/2024.
//

import Foundation
import Alamofire

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
 
    func fetchWeather(for latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let url = "\(Constants.baseURL)?key=\(Constants.apiKey)&q=\(latitude),\(longitude)&days=3&aqi=yes&alerts=no"
        
        AF.request(url).responseDecodable(of: WeatherResponse.self) { response in
            switch response.result {
            case .success(let weatherResponse):
                completion(.success(weatherResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
