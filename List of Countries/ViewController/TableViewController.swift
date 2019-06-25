//
//  TableViewController.swift
//  List of Countries
//
//  Created by Karim Cordilia on 24/06/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet weak var editButtonLabel: UIBarButtonItem!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Country.listOfCountries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        cell.textLabel?.text = Country.listOfCountries[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Country.listOfCountries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveableObject = Country.listOfCountries[sourceIndexPath.row]
        Country.listOfCountries.remove(at: sourceIndexPath.row)
        Country.listOfCountries.insert(moveableObject, at: destinationIndexPath.row)
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
            let country = Country.listOfCountries[indexPath.row]
            guard
                let destinationController = segue.destination as? DetailViewController
                else { assertionFailure("unexpected controller"); return }
            destinationController.countryName = country.name
        }
    }
}
