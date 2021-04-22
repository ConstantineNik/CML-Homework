//
//  PropertyDetailsViewController.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 22.04.2021.
//

import UIKit
import MapKit
import CoreLocation

class PropertyDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UITextView!
    
    private var viewModel: PropertyDetailsViewModelProtocol!
    
    var userProperty: UserProperty?
    var displayedDetails: ([String]?, [String: String])?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PropDetailsCell", bundle: nil), forCellReuseIdentifier: "ReusablePropCell")
        
        viewModel = PropertyDetailsViewModel()
        displayedDetails = userProperty?.getStructAsDictionary()
        
        if let lat = userProperty?.coordinates?.lat, let lng = userProperty?.coordinates?.lng {
            let initialLocation = CLLocation(latitude: lat, longitude: lng)
            mapView.centerToLocation(initialLocation)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation controllerdoes not exist")
        }
        
        DispatchQueue.main.async {
            self.title = "\(self.userProperty?.name ?? "Property") Details"
        }
        
        descriptionTitleLabel.text = "Description"
        
        if let descriptionText = userProperty?.description {
            let attributedString = self.viewModel.parseHtmlToString(descriptionText)
            DispatchQueue.main.async {
                self.descriptionTextLabel.attributedText = attributedString
            }
        }
        
        navBar.backgroundColor = .darkGray
    }
}

//MARK: - UITableView Data Source
extension PropertyDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedDetails?.0?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let propertyDetailKey = displayedDetails?.0?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusablePropCell", for: indexPath) as! PropDetailsCell
        
        
        cell.propertyNameLabel.text = propertyDetailKey
        cell.propertyValueLabel.text = displayedDetails?.1[propertyDetailKey!]

        return cell
    }
}

//MARK: - MapView Location
private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
