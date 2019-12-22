//
//  TableViewController.swift
//  List of Countries
//
//  Created by Karim Cordilia on 24/06/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    @IBOutlet weak var editButtonLabel: UIBarButtonItem!
    var fetchedResultsController: NSFetchedResultsController<Country>
    
    required init?(coder aDecoder: NSCoder) {
        let fetchRequest: NSFetchRequest<Country> = Country.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchedResultsController = NSFetchedResultsController<Country>(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.mainManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        CountryServerNetworking.loadAllCountryData { countries in
            countries.forEach { country in
                SingleCountry.countryCatalogue.append(SingleCountry(name: "\(country.name)", alpha2Code: "\(country.alpha2Code)"))
            }
        }
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error {
            assert(false, error.localizedDescription)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return SingleCountry.countryCount
        } else {
            return 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SingleCountry.sectionHeadersCount
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SingleCountry.sectionHeaders[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        cell.textLabel?.text = SingleCountry.listOfCountries[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SingleCountry.listOfCountries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveableObject = SingleCountry.listOfCountries[sourceIndexPath.row]
        SingleCountry.listOfCountries.remove(at: sourceIndexPath.row)
        SingleCountry.listOfCountries.insert(moveableObject, at: destinationIndexPath.row)
    }
    
    @IBAction func setEditingMode(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        sender.title = (self.tableView.isEditing ? "Done" : "Edit")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

extension TableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCountrySegue" {
            guard
                let indexPath = tableView.indexPathForSelectedRow
                else { return }
            let country = SingleCountry.listOfCountries[indexPath.row]
            guard
                let destinationController = segue.destination as? DetailViewController
                else { assertionFailure("unexpected controller"); return }
            destinationController.countryName = country.name
        }
    }
}
