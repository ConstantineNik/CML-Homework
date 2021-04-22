//
//  PropertyDetailsViewController.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 22.04.2021.
//

import UIKit

class PropertyDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation controllerdoes not exist")
        }
        
        title = "Property Details"
        
        navBar.backgroundColor = .darkGray
    }
}
