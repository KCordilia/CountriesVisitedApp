//
//  Country+Queries.swift
//  POSTExample
//
//  Created by Daniel Salber on 7/9/19.
//  Copyright © 2019 mackey.nl. All rights reserved.
//

import Foundation
import CoreData

extension Country {
    static func country(named name: String, in context: NSManagedObjectContext) -> Country? {
        let predicate = NSPredicate(format: "name == %@", argumentArray: [name])
        let request: NSFetchRequest<Country> = Country.fetchRequest()
        request.predicate = predicate
        do {
            let result = try context.fetch(request)
            return result.first
        } catch let error {
            assert(false, error.localizedDescription)
            return nil
        }
    }
}
