//
//  Annotation.swift
//  List of Countries
//
//  Created by Karim Cordilia on 02/07/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//

import Foundation
import MapKit

class Annotatddfdion: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var name: String?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
