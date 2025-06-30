//
//  OnlineSongModel.swift
//  Playlist
//
//  Created by Cristian Reyes Sánchez on 16/08/23.
//

import Foundation

struct OnlineSong: Codable {
    var id: String {
        return UUID().uuidString
    }
    let album: String
    let albumImageURL: String
    let artist: String
    let duration: String
    let name: String
    let year: Int
}
