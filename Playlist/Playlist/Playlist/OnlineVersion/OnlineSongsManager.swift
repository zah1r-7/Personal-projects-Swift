//
//  OnlineSongManager.swift
//  Playlist
//
//  Created by Cristian Reyes Sánchez on 16/08/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class OnlineSongsManager: ObservableObject {
    @Published var songs: [OnlineSong] = []
    @Published var allArtists: [Artist] = []
    
    let dataBase = Firestore.firestore()
        
    init() {
        getAllSongs()
        Thread.sleep(forTimeInterval: 1)
    }
    
    func getAllSongs(){
        //print("Dentro de funcion getAllSongs")
        dataBase.collection("Songs").getDocuments() { (querySnapshot, error)  in
            guard let documents = querySnapshot?.documents else {
                print("Error al traer los documentos: \(String(describing: error?.localizedDescription))")
                return
            }
            self.songs = documents.compactMap({ document -> OnlineSong? in
                do {
                    return try document.data(as: OnlineSong.self)
                } catch {
                    print("Error al decodificar el documento \(error.localizedDescription)")
                    return nil
                }
            })
            self.songs.sort(by: { song1, song2 in
                return song1.name < song2.name
            })
        }
    }
    
    func findAllArtists(in songs: [OnlineSong]) {
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
        artists.sort(by: { artist1, artist2 in
            return artist1.name < artist2.name
        })
        allArtists = artists
    }
}
