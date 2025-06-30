//
//  TableViewController.swift
//  MiApp
//
//  Created by Cristian Reyes Sánchez on 04/12/23.
//

import UIKit
import CoreLocation

class TableViewController: UITableViewController, SelectedStationDelegate, StationLocationDelegate {
   
    var locationDelegate: StationLocationDelegate?
    
    static var tripIsInProgress = Bool()
    
    var stations : [MetroStation] = [MetroStation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Selecciona tu destino"
    }
    
    func didSetOrCancelDestination(index: Int) {
        if TableViewController.tripIsInProgress {
            stations[index].isDestination = true
        } else {
            for (i, _) in stations.enumerated() {
                stations[i].isDestination = false
            }
        }
        tableView.reloadData()
    }
    
    func didSetStationAsDestination(center: CLLocationCoordinate2D, identifier: String) {
        locationDelegate?.didSetStationAsDestination(center: center, identifier: identifier)
    }
    // MARK: - Table view data source

    //# de secciones de la table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //# de filas por seccion
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    //Crear y retornar(mostrar) la celda correspondiente
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "metroStationCell", for: indexPath) as! MetroStationTableViewCell
        
        let station = stations[indexPath.row]
        cell.stationNameLabel.text = station.name
        cell.stationSymbolImageView.image = UIImage(named: station.symbolName)
        
        if let connections = station.otherLineConections {
            cell.otherLinesConnectionLabel.text = "Conecta con línea(s): \(connections.joined(separator: ","))"
        } else {
            cell.otherLinesConnectionLabel.text = "No conecta con otras líneas"
        }
        
        if station.isDestination {
            //cell.backgroundColor = UIColor(cgColor: CGColor(red: 135/255, green: 231/255, blue: 82/255, alpha: 1))
            cell.backgroundColor = UIColor(cgColor: CGColor(red: 97/255, green: 231/255, blue: 134/255, alpha: 1))
        } else {
            cell.backgroundColor = .systemBackground
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/7
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedStationVC = storyboard?.instantiateViewController(withIdentifier: "selectStationVC") as? selectedStationViewController {
            
            selectedStationVC.UIDelegate = self
            selectedStationVC.locationDelegate = self
            
            let station = stations[indexPath.row]
            selectedStationVC.stationSymbolImage = UIImage(named: station.symbolName)!
            
            if let connections = station.otherLineConections {
                selectedStationVC.otherLinesConnection = "\(connections.joined(separator: ","))"
            } else {
                selectedStationVC.otherLinesConnection = "Ninguna"
            }
            
            selectedStationVC.selectedStationIndex = indexPath.row
            selectedStationVC.selectedStationLocation = CLLocationCoordinate2D(latitude:station.location?.latitude ?? 0, longitude: station.location?.longitude ?? 0)
            
            
            self.present(selectedStationVC, animated: true)
        }
    }
}
