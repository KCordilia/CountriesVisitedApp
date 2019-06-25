//
//  DetailViewController.swift
//  List of Countries
//
//  Created by Karim Cordilia on 24/06/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var countryNameLabel: UILabel!
    
    var countryName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryNameLabel.text = countryName
        title = countryName
    }
}
