//
//  WeatherAPI.swift
//  List of Countries
//
//  Created by Karim Cordilia on 03/07/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//

import Foundation

struct ServerData: Codable {
    let data: [ServerWeather]
}

struct ServerWeather: Codable {
    let city_name: String
    let temp: Double
    let weather: ServerWeatherInfo
}

struct ServerWeatherInfo: Codable {
    let icon: String
    let description: String
}


struct WeatherServerNetworking {
    static func getAPIData(_ name: String, completion: @escaping (Data) -> Void) {
        let endPoint = "https://api.weatherbit.io/v2.0/current?city=\(name)&key=1b5a2dcc00d1472b860dc2b0ccc8c683"
        let url = URL(string: endPoint)!
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            completion(data!)
        }
        task.resume()
    }
    
    static func loadWeatherData(_ name: String, completion: @escaping (ServerData) -> Void) {
        getAPIData(name) { resultData in
            do {
                let decoder = JSONDecoder()
                let decodedResult = try decoder.decode(ServerData.self, from: resultData)
                completion(decodedResult)
            } catch let error{
                print(error)
            }
        }
    }
}
