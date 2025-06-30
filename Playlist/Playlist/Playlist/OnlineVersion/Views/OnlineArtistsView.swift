//
//  OnlineArtistsView.swift
//  Playlist
//
//  Created by Cristian Reyes Sánchez on 17/08/23.
//

import SwiftUI

struct OnlineArtistsView: View {
    
    @ObservedObject var onlineSongsVM = OnlineSongsManager()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(onlineSongsVM.allArtists, id: \.id) {artist in
                    VStack(alignment: .leading) {
                        Text(artist.name)
                            .font(.title2)
                            .bold()
                        ScrollView(.horizontal) {
                            HStack(spacing: 15) {
                                ForEach(onlineSongsVM.songs, id: \.id) {song in
                                    if song.artist == artist.name {
                                        NavigationLink {
                                            DetailedOnlineSongView(onlineSong: song)
                                        } label: {
                                            VStack(spacing: 5) {
                                                AsyncImage(url: URL(string: song.albumImageURL)) { image in
                                                    image
                                                        .resizable()
                                                        .frame(width: 140, height: 140)
                                                        .cornerRadius(15)
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                                Text("\(song.name)")
                                                    .font(.subheadline)
                                                    .foregroundColor(.black)
                                                    .bold()
                                                    .fixedSize(horizontal: false, vertical: true)
                                                    .padding(.bottom, 25)
                                            }.frame(maxWidth: 140)
                                            
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
                onlineSongsVM.findAllArtists(in: onlineSongsVM.songs)
            }
        }
    }
}

struct OnlineArtistsView_Previews: PreviewProvider {
    static var previews: some View {
        OnlineArtistsView()
    }
}
