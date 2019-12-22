//
//  CountryAPI.swift
//  List of Countries
//
//  Created by Karim Cordilia on 02/07/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//

import Foundation
import CoreLocation

struct ServerCountry: Codable {
    let name: String
    let latitudeLongitude: [Double]
    let population: Int
    let capital: String
    let alpha2Code: String
    // This is a computed value that converts the values in the latitudeLongitude variable into a more readable format
    var coordinates: CLLocationCoordinate2D? {
        if latitudeLongitude.count != 2 { return nil }
        return CLLocationCoordinate2D(latitude: latitudeLongitude[0], longitude: latitudeLongitude[1])
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case latitudeLongitude = "latlng"
        case population = "population"
        case capital = "capital"
        case alpha2Code = "alpha2Code"
    }
}

struct CountryServerNetworking {
    // This function makes a URL Request to the API with a country name as an argument and returns the data for that country
    static func getAPIData(_ name: String, completion: @escaping (Data) -> Void) {
        let endPoint = "https://restcountries.eu/rest/v2/name/\(name)"
        guard
            let url = URL(string: endPoint)
            else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            completion(data!)
        }
        task.resume()
    }
    
    static func getAllAPIData( completion: @escaping (Data) -> Void) {
        let endPoint = "https://restcountries.eu/rest/v2/all"
        guard
            let url = URL(string: endPoint)
            else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            completion(data!)
        }
        task.resume()
    }
    
    // This function loads the data that it gets from the API call and decodes it into a readable format with a completion handler 
    static func loadCountryData(_ name: String, completion: @escaping (ServerCountry) -> Void) {
        getAPIData(name) { resultData in
            do {
                let decoder = JSONDecoder()
                let decodedResult = try decoder.decode([ServerCountry].self, from: resultData)
                completion(decodedResult[0])
            } catch {
                print("failed")
            }
        }
    }
    
    static func loadAllCountryData(completion: @escaping ([ServerCountry]) -> Void) {
        getAllAPIData { resultData in
            do {
                let decoder = JSONDecoder()
                let decodedResult = try decoder.decode([ServerCountry].self, from: resultData)
                Country.saveCountries(decodedResult)
                completion(decodedResult)
            } catch {
                print("failed")
            }
        }
    }
}

