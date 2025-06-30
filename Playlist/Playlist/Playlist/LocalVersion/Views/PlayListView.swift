//
//  ContentView.swift
//  Playlist
//
//  Created by Alumno on 09/08/23.
//

import Foundation
import SwiftUI

struct PlayListView: View {
    @ObservedObject var songsVM = SongsManager()
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(songsVM.songs, id: \.id) { song in
                        NavigationLink {
                            DetailedSongView(song: song)
                        } label: {
                            HStack {
                                Image("\(song.albumImage)")
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                    .padding(5)
                                VStack(alignment: .leading) {
                                    Text("\(song.name)")
                                        .font(.title2)
                                    Text("\(song.artist)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text(" - \(song.album)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }

                    }
                }
                .task {
                    await songsVM.songs = songsVM.getSongs2()
                }
                .navigationTitle("Playlist")
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlayListView()
    }
}
