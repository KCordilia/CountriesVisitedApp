//
//  CountryFlagsCollectionViewController.swift
//  List of Countries
//
//  Created by Karim Cordilia on 25/06/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class CountryFlagsCollectionViewController: UICollectionViewController {
    @IBOutlet weak var doneAddingCountries: UIBarButtonItem!
    var selectedCountries: [Country] = []
    var fetchedResultsController: NSFetchedResultsController<Country>
    let context = CoreDataStack.shared.mainManagedObjectContext

    
    required init?(coder aDecoder: NSCoder) {
        let fetchRequest: NSFetchRequest<Country> = Country.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchedResultsController = NSFetchedResultsController<Country>(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.mainManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        do {
           try fetchedResultsController.performFetch()
        } catch let error {
            assert(false, error.localizedDescription)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sectionInfo: AnyObject = fetchedResultsController.sections?[section] {
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryFlagCell", for: indexPath) as? CountryFlagCell
            else { preconditionFailure("no cell") }
        
        let country = fetchedResultsController.object(at: IndexPath(row: indexPath.row, section: 0))
        let alpha2Code = country.alpha2Code
        
        guard
            let url = URL(string: "https://raw.githubusercontent.com/hjnilsson/country-flags/master/png250px/\(alpha2Code.lowercased()).png")
            else { fatalError() }
        
        cell.countryFlagImage.kf.setImage(with: url)
        cell.countryNameLabel.text = country.name
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let country = fetchedResultsController.object(at: IndexPath(row: indexPath.row, section: 0))
        selectedCountries.append(country)
        guard
            let cell = collectionView.cellForItem(at: indexPath)
            else { return }
        if cell.isSelected == true {
            cell.backgroundColor = UIColor(red: 98.0 / 255.0, green: 98.0 / 255.0, blue: 98.0 / 255.0, alpha: 0.2)
        }
        doneAddingCountries.isEnabled = true
        showAlert()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectedCountries.remove(at: 0)
    
        guard
            let cell = collectionView.cellForItem(at: indexPath)
            else { return }
        cell.backgroundColor = UIColor.clear
    }
    
    @IBAction func addCountries(_ sender: UIBarButtonItem) {
        SingleCountry.listOfCountries.append(selectedCountries[0])
        dismiss(animated: true, completion: nil)
        selectedCountries.removeAll()
    }
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let reallyWantToGoAction = UIAlertAction(title: "Really want to go", style: .default, handler: nil)
        let wantToGoAction = UIAlertAction(title: "Want to go", style: .default, handler: nil)
        let maybeWantToGoAction = UIAlertAction(title: "Maybe want to go", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(reallyWantToGoAction)
        alert.addAction(wantToGoAction)
        alert.addAction(maybeWantToGoAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

