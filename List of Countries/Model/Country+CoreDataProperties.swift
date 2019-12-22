//
//  Country+CoreDataProperties.swift
//  List of Countries
//
//  Created by Karim Cordilia on 10/07/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var name: String
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var population: Int64
    @NSManaged public var alpha2Code: String
    @NSManaged public var preference: String

}
