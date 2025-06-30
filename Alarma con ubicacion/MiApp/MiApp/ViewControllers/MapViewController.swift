//
//  MapViewController.swift
//  MiApp
//
//  Created by Cristian Reyes Sánchez on 30/08/23.
//

//import Foundation
import UIKit
import MapKit
import CoreLocation

/*
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destinationVC = segue.destination as! MapViewController
    destinationVC.metroLineLocation = CLLocationCoordinate2D(latitude: 19.398237, longitude: -99.200363)
    
    
    guard let sender = sender as? UIButton else {return}
    let metroLineID = sender.restorationIdentifier
    
}
*/

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private let appName = MainViewController.appName
    private let locationManager = CLLocationManager()
    var metroLineLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLocationManager()
        //setUpNavigationBar()
    }
    
    private func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    private func setUpNavigationBar() {
        
        let customBackButton: UIButton = {
            let button = UIButton()
            button.setTitle("  < Back  ", for: .normal)
            button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
            button.backgroundColor = .label
            button.setTitleColor(.systemBackground, for: .normal)
            button.layer.cornerRadius = 18
            button.addTarget(self, action: #selector(dismissMapView), for: .touchUpInside)
            return button
        }()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customBackButton)
    }
    
    @objc private func dismissMapView() {
        performSegue(withIdentifier: "unwindToMainViewSegue", sender: self)
    }
    
    private func centerViewOnMetroLineLocation() {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 19.426732, longitude: -99.137685), latitudinalMeters: 30000, longitudinalMeters: 500)
        let linePin = MKPointAnnotation()
        linePin.coordinate = metroLineLocation
        linePin.title = "Observatorio"
        let linePin2 = MKPointAnnotation()
        linePin2.coordinate = CLLocationCoordinate2D(latitude: 19.415359, longitude: -99.072132)
        linePin2.title = "Pantitlán"
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(linePin)
        mapView.addAnnotation(linePin2)
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            print("1")
            //mapView.showsUserLocation = true
            //centerViewOnMetroLineLocation()
            break
        case .authorizedWhenInUse:
            print("2")
            mapView.showsUserLocation = true
            centerViewOnMetroLineLocation()
            //locationManager.requestAlwaysAuthorization()
            break
        case .notDetermined:
            print("3")
            locationManager.requestWhenInUseAuthorization()
            //locationManager.requestAlwaysAuthorization()
            break
        case .denied:
            print("4")
            DispatchQueue.global().async {
                if CLLocationManager.locationServicesEnabled() {
                    DispatchQueue.main.sync {
                        locationServicesForAppAreOffAlert()
                    }
                } else {
                    locationServicesGloballyOffAlert()
                }
            }
            break
        case .restricted:
            print("5")
            locationServicesRestrictedAlert()
            break
        default:
            break
        }
        
        func locationServicesForAppAreOffAlert() {
            let locationServicesForAppOffAlert: UIAlertController = {
                let alert = UIAlertController(title: "\(appName) no tiene acceso a la ubicación", message: "Por favor, permite el acceso de la aplicación a la ubicación del dispositivo: Configuración > Privacidad > Localización > \(appName) > Permitir acceso a la ubicación Siempre", preferredStyle: .alert)
                let settingsButton = UIAlertAction(title: "Configuración", style: .cancel) { (_) -> Void in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {return}
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl)
                    }
                }
                let dismissButton = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(settingsButton)
                alert.addAction(dismissButton)
                return alert
            }()
            self.present(locationServicesForAppOffAlert, animated: true)
        }
        
        func locationServicesGloballyOffAlert() {
            let locationServicesGloballyOffAlert: UIAlertController = {
                let alert = UIAlertController(title: "Ubicación desactivada", message: "Por favor, activa la ubicación de tu dispositivo para poder usar la aplicación: Configuración > Privacidad > Localizacón > Activa la localización > \(appName) > Permitir acceso a la ubicación siempre", preferredStyle: .alert)
                let settingsButton = UIAlertAction(title: "Configuración", style: .cancel) { (_) -> Void in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {return}
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl)
                    }
                }
                let dismissButton = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(settingsButton)
                alert.addAction(dismissButton)
                return alert
            }()
            self.present(locationServicesGloballyOffAlert, animated: true)
        }
        
        func locationServicesRestrictedAlert() {
            let locationServicesRestrictedAlert: UIAlertController = {
                let alert = UIAlertController(title: "Ubicación restringida", message: "La ubicación de tu dispositivo para \(appName) se encuentra restringida, esto puede ser debido a un bloqueo parental; por lo que no podrás usar la aplicación. ", preferredStyle: .alert)
                let dismissButton = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(dismissButton)
                return alert
            }()
            self.present(locationServicesRestrictedAlert, animated: true)
        }
    }
}

 
