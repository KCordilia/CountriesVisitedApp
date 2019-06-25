//
//  AddCountryViewController.swift
//  List of Countries
//
//  Created by Karim Cordilia on 25/06/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//

import UIKit

class AddCountryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addCountryTextfield: UITextField!
    @IBOutlet weak var doneAddingCountryButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        addCountryTextfield.delegate = self
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (addCountryTextfield.text! as NSString).replacingCharacters(in: range, with: string)
        if text.isEmpty {
            doneAddingCountryButton.isEnabled = false
        } else {
            doneAddingCountryButton.isEnabled = true
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addCountryTextfield.resignFirstResponder()
        addCountries()
        return true
    }


    @IBAction func doneAddingCountry(_ sender: UIBarButtonItem) {
        addCountries()
    }


    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func addCountries() {
        guard
            let addCountryTextfield = addCountryTextfield.text
            else { return }

        let multipleCountriesArray = addCountryTextfield.split(separator: ",")
        multipleCountriesArray.forEach { country in
            Country.listOfCountries.append(Country(name: "\(country.capitalized)"))
        }

        dismiss(animated: true, completion: nil)
    }

}
