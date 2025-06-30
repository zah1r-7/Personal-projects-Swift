import UIKit

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

let line1: MetroLine = MetroLine(num: "1", stations: [
    MetroStation(name: "Observatorio", symbolName: "observatorio", location: nil, otherLineConections: nil),
    MetroStation(name: "Tacubaya", symbolName: "tacubaya", location: nil, otherLineConections: ["7","9"]),
    MetroStation(name: "Juanacatlán", symbolName: "juanacatlan", location: nil, otherLineConections: nil),
    MetroStation(name: "Chapultepec", symbolName: "chapultepec", location: nil, otherLineConections: nil),
    MetroStation(name: "Sevilla", symbolName: "sevilla", location: nil, otherLineConections: nil),
    MetroStation(name: "Insurgentes", symbolName: "insurgentes", location: nil, otherLineConections: nil)
])

let line3: MetroLine = MetroLine(num: "3", stations: [
    MetroStation(name: "Indios Verdes", symbolName: "indiosverdes", location: nil, otherLineConections: nil),
    MetroStation(name: "Deportivo 18 de Marzo", symbolName: "deportivo18marzo", location: nil, otherLineConections: ["6"]),
    MetroStation(name: "Potrero", symbolName: "potrero", location: nil, otherLineConections: nil),
    MetroStation(name: "La Raza", symbolName: "laraza", location: nil, otherLineConections: ["5"]),
    MetroStation(name: "Tlatelolco", symbolName: "tlatelolco", location: nil, otherLineConections: nil),
    MetroStation(name: "Guerrero", symbolName: "guerrero", location: nil, otherLineConections: ["B"]),
    MetroStation(name: "Hidalgo", symbolName: "hidalgo", location: nil, otherLineConections: nil),
    MetroStation(name: "Juárez", symbolName: "juarez", location: nil, otherLineConections: nil),
    MetroStation(name: "Balderas", symbolName: "balderas", location: nil, otherLineConections: ["1"]),
    MetroStation(name: "Niños héroees/ Poder Judicial CDMX", symbolName: "poderjudicial", location: nil, otherLineConections: nil),
    MetroStation(name: "Hospital General", symbolName: "hospitalgeneral", location: nil, otherLineConections: nil),
    MetroStation(name: "Centro médico", symbolName: "centromedico", location: nil, otherLineConections: ["9"]),
    MetroStation(name: "Etiopía/ Plaza de la Transparencia", symbolName: "etiopiaplaza", location: nil, otherLineConections: nil),
    MetroStation(name: "Eugenia", symbolName: "eugenia", location: nil, otherLineConections: nil),
    MetroStation(name: "División del Norte", symbolName: "divisiondelnorte", location: nil, otherLineConections: nil),
    MetroStation(name: "Zapata", symbolName: "zapata", location: nil, otherLineConections: ["12"]),
    MetroStation(name: "Coyoacán", symbolName: "coyoacan", location: nil, otherLineConections: nil),
    MetroStation(name: "Viveros/ Derechos humanos", symbolName: "viverosderechos", location: nil, otherLineConections: nil),
    MetroStation(name: "Miguel Ángel de Quevedo", symbolName: "maquevedo", location: nil, otherLineConections: nil),
    MetroStation(name: "Copilco", symbolName: "copilco", location: nil, otherLineConections: nil),
    MetroStation(name: "Universidad", symbolName: "universidad", location: Coordinate(latitude: 19.324427, longitude: -99.17397), otherLineConections: nil)
])

let lines: [MetroLine] = [line1,line3]

let encoder = JSONEncoder()

if let jsonData = try? encoder.encode(lines),
   let jsonString = String(data: jsonData, encoding: .utf8) {
    print(jsonString)
}
