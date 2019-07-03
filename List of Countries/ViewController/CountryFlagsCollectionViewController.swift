//
//  CountryFlagsCollectionViewController.swift
//  List of Countries
//
//  Created by Karim Cordilia on 25/06/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//

import UIKit

class CountryFlagsCollectionViewController: UICollectionViewController {

    @IBOutlet weak var doneAddingCountries: UIBarButtonItem!
    var selectedCountries: [Country] = []

    override func viewDidLoad() {
        collectionView.allowsMultipleSelection = true
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return Country.countryFlagCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryFlagCell", for: indexPath) as? CountryFlagCell
            else { preconditionFailure("no cell") }
        let nameWithUnderscores = Country.countries[indexPath.item].name.replacingOccurrences(of: " ", with: "_")
        cell.countryFlagImage.image = UIImage(named: "\(nameWithUnderscores)")
        cell.countryNameLabel.text = Country.countries[indexPath.item].name

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCountries.append(Country.countries[indexPath.item])
        guard
            let cell = collectionView.cellForItem(at: indexPath)
            else { return }
        if cell.isSelected == true {
            cell.backgroundColor = UIColor(red: 98.0 / 255.0, green: 98.0 / 255.0, blue: 98.0 / 255.0, alpha: 0.2)
        }
        doneAddingCountries.isEnabled = true
    }

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectedCountries.remove(at: indexPath.item)
    
        guard
            let cell = collectionView.cellForItem(at: indexPath)
            else { return }
        cell.backgroundColor = UIColor.clear
    }

    @IBAction func addCountries(_ sender: UIBarButtonItem) {
        Country.listOfCountries.append(contentsOf: selectedCountries)
        dismiss(animated: true, completion: nil)
        selectedCountries.removeAll()
    }

    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

