//
//  MetroLineModel.swift
//  MiApp
//
//  Created by Cristian Reyes Sánchez on 12/09/23.
//

import Foundation
import MapKit

struct MetroLine: Codable {
    let num: String
    let stations: [MetroStation]
}

struct MetroStation: Codable {
    let name: String
    let symbolName: String
    let location: Coordinate?
    let otherLineConections: [String]?
    var isDestination = Bool()
}

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
}
