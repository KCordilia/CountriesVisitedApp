//
//  CountryData.swift
//  List of Countries
//
//  Created by Karim Cordilia on 24/06/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//

import MapKit

struct SingleCountry {
    let name: String
    let alpha2Code: String
    
    static var countryCount: Int {
        return SingleCountry.listOfCountries.count
    }
    
    static var sectionHeadersCount: Int {
        return SingleCountry.sectionHeaders.count
    }
    
    static var countryFlagCount: Int {
        return SingleCountry.countryCatalogue.count
    }
    
    static let sectionHeaders = ["Visited", "Want to visit"]
    
    static var listOfCountries: [Country] = []

    
    static var countryCatalogue: [SingleCountry] = []
    
    
}
