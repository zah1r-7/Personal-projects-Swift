//
//  SongViewModel.swift
//  Playlist
//
//  Created by Alumno on 09/08/23.
//

import Foundation


class SongsManager: ObservableObject {
    @Published var songs: [Song] = []
    @Published var songsByArtist: [[Song]] = []
    @Published var allArtists: [Artist] = []
        
    func getSongs2() async -> [Song] {
        print("buscando json")
        guard let path = Bundle.main.path(forResource: "music", ofType: "JSON") else {return []}
        let url = URL(fileURLWithPath: path)
        print("json encontrado")

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let songs = try decoder.decode([Song].self, from: data)
            print(songs)
            return songs
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func findAllArtists(in songs: [Song]) -> [Artist] {
        var artistsNames: [String] = []
        var artists: [Artist] = []
        for song in songs {
            let currentArtistName = song.artist
            if !artistsNames.contains(currentArtistName) {
                artistsNames.append(currentArtistName)
                let newArtist = Artist(name: currentArtistName)
                artists.append(newArtist)
            }
        }
        return artists
    }
    

    
//        func getSongs() async {
//            print("buscando json")
//            guard let path = Bundle.main.path(forResource: "music", ofType: "JSON") else {return}
//            let url = URL(fileURLWithPath: path)
//            print("json encontrado")
//
//            do {
//                let (data, _) = try await URLSession.shared.data(from: url)
//                let decoder = JSONDecoder()
//                let songs = try decoder.decode([Song].self, from: data)
//                self.songs = songs
//
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
}
