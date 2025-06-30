//
//  ArtistModel.swift
//  Playlist
//
//  Created by Cristian Reyes Sánchez on 14/08/23.
//

import Foundation

struct Artist: Codable {
    var id: String {
        return UUID().uuidString
    }
    let name: String
}
