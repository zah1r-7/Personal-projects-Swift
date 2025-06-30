//
//  SongModel.swift
//  Playlist
//
//  Created by Alumno on 09/08/23.
//

import Foundation

struct Song: Codable {
    var id: String {
        return UUID().uuidString
    }
    let name: String
    let year: Int
    let album: String
    let albumImage: String
    let artist: String
    let duration: String
    
//    init(id: String = UUID().uuidString, name: String, year: Int, album: String, albumImage: String, artist: String, duration: String) {
//        self.id = id
//        self.name = name
//        self.year = year
//        self.album = album
//        self.albumImage = albumImage
//        self.artist = artist
//        self.duration = duration
//    }
}
