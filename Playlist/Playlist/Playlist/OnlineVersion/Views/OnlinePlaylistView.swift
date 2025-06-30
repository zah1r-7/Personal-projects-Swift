//
//  OnlinePlaylistView.swift
//  Playlist
//
//  Created by Cristian Reyes Sánchez on 16/08/23.
//

import SwiftUI

struct OnlinePlaylistView: View {
    
    @ObservedObject var onlineSongsVM = OnlineSongsManager()
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(onlineSongsVM.songs, id: \.id) { song in
                        NavigationLink {
                            DetailedOnlineSongView(onlineSong: song)
                        } label: {
                            HStack {
                                AsyncImage(url: URL(string: song.albumImageURL)) { image in
                                    image
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                        .cornerRadius(15)
                                        .padding(5)
                                } placeholder: {
                                    ProgressView()
                                }
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
                .navigationTitle("Playlist")
            }
        }
    }
}

struct OnlinePlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        OnlinePlaylistView()
    }
}
