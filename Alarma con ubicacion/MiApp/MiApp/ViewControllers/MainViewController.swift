//
//  ViewController.swift
//  MiApp
//
//  Created by Cristian Reyes Sánchez on 29/08/23.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    lazy var locationManager = CLLocationManager()
    
    //Acceder al diccionario con la info relacionada a la app(info.plist) y obtener el nombre de la App
    static let appName = (Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String)!
    private let appName = MainViewController.appName
    private var lines: [MetroLine] = [MetroLine]()
    private var selectedLine: MetroLine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLocationManager()
        setUpNavigationBar()
        getData()
    }
    
    @IBAction func lineButtonPressed(_ sender: UIButton) {
        let selectedLineNumber = String(sender.restorationIdentifier!)
        for line in lines {
            if line.num == selectedLineNumber {
                selectedLine = line
                break
            } else {
                selectedLine = nil
            }
        }
        performSegue(withIdentifier: "selectTripDirectionViewSegue", sender: sender)
    }
    
    @IBAction func unwindToMainView(_ sender: UIStoryboardSegue) {}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tripDirectionVC = segue.destination as! TripDirectionViewController
        tripDirectionVC.locationDelegate = self
        if let selectedLineStations = selectedLine?.stations {
            tripDirectionVC.stations = selectedLineStations
        }
    }
    
    private func setUpNavigationBar() {
        navigationController?.navigationBar.tintColor = .label
    }
    
    private func getData() {
        do {
            //Crear un path(camino) del bundle principal(main) y obtener el objeto de datos(DATA) del path
            if let path = Bundle.main.path(forResource: "metroStations", ofType: "JSON"),
               let jsonData = try? String(contentsOfFile: path).data(using: .utf8){

                //Decodificar el arreglo de tipo 'MetroLine' de los datos del JSON
                let data = try JSONDecoder().decode([MetroLine].self, from: jsonData)
                lines = data
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.allowsBackgroundLocationUpdates = true
    }
}


extension MainViewController: CLLocationManagerDelegate, StationLocationDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            print("1")
            break
        case .authorizedWhenInUse:
            print("2")
            break
        case .notDetermined:
            print("3")
            locationManager.requestWhenInUseAuthorization()
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
    
    func didSetStationAsDestination(center: CLLocationCoordinate2D, identifier: String) {
        
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            let maxDistance = CLLocationDistance(100)
            let station = CLCircularRegion(center: center, radius: maxDistance, identifier: identifier)
            station.notifyOnEntry = true
            station.notifyOnExit = false
            
            locationManager.startMonitoring(for: station)
            print(center)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if let region = region as? CLCircularRegion {
            let identifier = region.identifier
            print(identifier)
        }
    }
}
