//
//  selectStationViewController.swift
//  MiApp
//
//  Created by Cristian Reyes Sánchez on 08/01/24.
//

import UIKit
import CoreLocation

protocol SelectedStationDelegate {
    func didSetOrCancelDestination(index: Int)
}

protocol StationLocationDelegate {
    func didSetStationAsDestination(center: CLLocationCoordinate2D, identifier: String)
}

class selectedStationViewController: UIViewController {

    var UIDelegate: SelectedStationDelegate?
    var locationDelegate: StationLocationDelegate?
    
    @IBOutlet weak var stationSymbolImageView: UIImageView!
    @IBOutlet weak var otherLinesConnectionLabel: UILabel!
    @IBOutlet weak var landmarksLabel: UILabel!
    @IBOutlet weak var setDestinationButton: UIButton!
    @IBOutlet weak var cancelTripButton: UIButton!
    
    var stationSymbolImage = UIImage()
    var otherLinesConnection = String()
    var selectedStationIndex = Int()
    var selectedStationLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func setDestinationButtonPressed(_ sender: UIButton) {
        TableViewController.tripIsInProgress = true
        updateUI()
        UIDelegate?.didSetOrCancelDestination(index: selectedStationIndex)
        locationDelegate?.didSetStationAsDestination(center: selectedStationLocation, identifier: UUID().uuidString)
        
    }
    
    @IBAction func cancelTripButtonPressed(_ sender: UIButton) {
        TableViewController.tripIsInProgress = false
        updateUI()
        UIDelegate?.didSetOrCancelDestination(index: selectedStationIndex)
    }
    
    private func updateUI() {
        stationSymbolImageView.image = stationSymbolImage
        otherLinesConnectionLabel.text = otherLinesConnection
        
        if TableViewController.tripIsInProgress {
            setDestinationButton.isHidden = true
            setDestinationButton.isEnabled = false
            cancelTripButton.isHidden = false
            cancelTripButton.isEnabled = true
        } else {
            setDestinationButton.isHidden = false
            setDestinationButton.isEnabled = true
            cancelTripButton.isHidden = true
            cancelTripButton.isEnabled = false
        }
    }
}
