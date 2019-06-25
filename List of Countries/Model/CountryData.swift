//
//  CountryData.swift
//  List of Countries
//
//  Created by Karim Cordilia on 24/06/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//


struct Country {
    let name: String
    
    static var listOfCountries: [Country] = [
        Country(name: "Afghanistan"),
        Country(name: "Belarus"),
        Country(name: "Haiti"),
        Country(name: "Japan"),
        Country(name: "Indonesia")
    ]
}
