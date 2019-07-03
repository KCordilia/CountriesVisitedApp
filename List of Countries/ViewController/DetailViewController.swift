//
//  DetailViewController.swift
//  List of Countries
//
//  Created by Karim Cordilia on 24/06/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class DetailViewController: UIViewController {

    var countryName: String? // Change to Country struct
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var customCalloutView: AnnotationView!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var capitalNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = countryName
//        Country.createCountryCatalogue()
        
        guard
            let countryName = countryName?.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
            else { return }
        // This function call takes a country name as an argument and a trailing closure that waits for the data to be available before loading it into the view
        CountryServerNetworking.loadCountryData(countryName) { country in
            guard
                let coordinates = country.coordinates,
                let capital = country.capital.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
                else { return }
            
            DispatchQueue.main.async {
                self.centerOnRegion(coordinates: coordinates)
                self.placeAnnotation(country: country)
            }
            WeatherServerNetworking.loadWeatherData(capital, completion: { weather  in
                DispatchQueue.main.async {
                    self.setWeatherLabels(weather: weather, country: country)
                }
            })
        }
        
    }
    
    func setWeatherLabels(weather: ServerData, country: ServerCountry) {
        self.capitalNameLabel.text = country.capital
        self.weatherIcon.image = UIImage(named: "\(weather.data[0].weather.icon)")
        self.temperatureLabel.text = "\(String(weather.data[0].temp))\u{2103}"
        self.weatherDescriptionLabel.text = weather.data[0].weather.description
        self.populationLabel.text = String(country.population)
    }
    
    func centerOnRegion(coordinates: CLLocationCoordinate2D) {
        // This block takes care of the zoom- and camera position based on the latitude and longitude
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
    func placeAnnotation(country: ServerCountry) {
        guard
            let coordinates = country.coordinates
            else { return }
        // This block creates a marker on the map at the location of the country with a title and subtitle
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
//        annotationView.populationLabel.text = "Population: \(String(country.population))"
        self.mapView.addAnnotation(annotation)
    }
}

extension DetailViewController: MKMapViewDelegate {
    // This protocol function converts the marker to a pin with a callout(popup) that shows the title and subtitle
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        annotationView?.detailCalloutAccessoryView = customCalloutView
        return annotationView
    }
}


