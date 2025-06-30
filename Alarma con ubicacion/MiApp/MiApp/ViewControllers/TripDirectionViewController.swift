//
//  TripDirectionViewController.swift
//  MiApp
//
//  Created by Cristian Reyes Sánchez on 06/12/23.
//

import UIKit
import CoreLocation

class TripDirectionViewController:UIViewController, StationLocationDelegate {
   
    @IBOutlet weak var firstStationButton: UIButton!
    @IBOutlet weak var lastStationButton: UIButton!
    
    var locationDelegate: StationLocationDelegate?
    
    var stations: [MetroStation] = [MetroStation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        //print(stations)
    }
    
    @IBAction func stationButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "tableViewSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tableViewVC = segue.destination as! TableViewController
        tableViewVC.stations = stations
        tableViewVC.locationDelegate = self
    }
    
    
    private func setUpUI() {
        if !(stations.isEmpty) {
            firstStationButton.setBackgroundImage(UIImage(named: stations.first!.symbolName.lowercased()), for: .normal)
            lastStationButton.setBackgroundImage(UIImage(named: stations.last!.symbolName.lowercased()), for: .normal)
        }
    }
    
    func didSetStationAsDestination(center: CLLocationCoordinate2D, identifier: String) {
        locationDelegate?.didSetStationAsDestination(center: center, identifier: identifier)
    }
    
}
