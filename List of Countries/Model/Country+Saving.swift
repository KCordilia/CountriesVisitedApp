//
//  Country+Saving.swift
//  POSTExample
//
//  Created by Daniel Salber on 7/9/19.
//  Copyright © 2019 mackey.nl. All rights reserved.
//

import Foundation
import CoreData

extension Country {
    static func saveCountries(_ serverCountries: [ServerCountry]) {
        let backgroundContext = CoreDataStack.shared.persistentContainer.newBackgroundContext()
        
        serverCountries.forEach { serverCountry in
            if Country.country(named: serverCountry.name, in: backgroundContext) == nil {
                _ = Country(from: serverCountry, in: backgroundContext)
            }
        }
        CoreDataStack.shared.saveContext(backgroundContext)
        
    }
}
