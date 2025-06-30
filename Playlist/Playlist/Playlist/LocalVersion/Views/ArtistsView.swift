//
//  ArtistsView.swift
//  Playlist
//
//  Created by iOs Dev Lab on 11/08/23.
//

import SwiftUI

struct ArtistsView: View {
    
    @ObservedObject var songsVM = SongsManager()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(songsVM.allArtists, id: \.id) {artist in
                    VStack(alignment: .leading) {
                        Text(artist.name)
                            .font(.title2)
                            .bold()
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(songsVM.songs, id: \.id) {song in
                                    if song.artist == artist.name {
                                        NavigationLink {
                                            DetailedSongView(song: song)
                                        } label: {
                                            VStack(spacing: 0) {
                                                Image("\(song.albumImage)")
                                                    .resizable()
                                                    .frame(width: 140, height: 140)
                                                    .padding(5)
                                                    .cornerRadius(25)
                                                Text("\(song.name)")
                                                    .font(.subheadline)
                                                    .foregroundColor(.black)
                                                
                                            }
                                        }

                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
            .navigationTitle("Artists")
            .task {
                await songsVM.songs = songsVM.getSongs2()
                songsVM.allArtists = songsVM.findAllArtists(in: songsVM.songs)
                print(songsVM.allArtists)
            }
        }
    }
}

struct ArtistsView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistsView()
    }
}
