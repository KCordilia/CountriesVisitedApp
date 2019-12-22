//
//  Country+CoreDataClass.swift
//  List of Countries
//
//  Created by Karim Cordilia on 10/07/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//
//

import Foundation
import CoreData

public class Country: NSManagedObject {
    convenience init(from serverCountry: ServerCountry, in context: NSManagedObjectContext) {
        self.init(context: context)
        name = serverCountry.name
        population = Int64(serverCountry.population)
        latitude = serverCountry.latitudeLongitude.first ?? 0
        longitude = serverCountry.latitudeLongitude.last ?? 0
        alpha2Code = serverCountry.alpha2Code
    }
}
