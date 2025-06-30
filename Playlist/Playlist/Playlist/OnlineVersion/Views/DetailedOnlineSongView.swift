//
//  DetailedOnlineSongView.swift
//  Playlist
//
//  Created by Cristian Reyes Sánchez on 16/08/23.
//

import SwiftUI

struct DetailedOnlineSongView: View {
    
    let onlineSong: OnlineSong
    @State var isPlaying: Bool = false
    
    var body: some View {
            ScrollView {
                AsyncImage(url: URL(string: onlineSong.albumImageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 20)
                        .padding(.bottom, 5)
                } placeholder: {
                    ProgressView()
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text(onlineSong.name)
                            .font(.headline)
                        Text(String("(\(onlineSong.year))"))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text(onlineSong.artist)
                            .font(.subheadline)
                        Spacer()
                        Text(onlineSong.album)
                            .font(.subheadline)
                    }
                }.padding(.leading, 25).padding(.trailing, 25)
                HStack(spacing: 50) {
                    Button {
                        
                    } label: {
                        Image(systemName: "backward.circle.fill")
                            .scaleEffect(3)
                            .foregroundColor(.red)
                    }
                    Button {
                        
                        self.isPlaying.toggle()
                    } label: {
                        Image(systemName: self.isPlaying ? "pause.circle.fill":"play.circle.fill")
                            .scaleEffect(4)
                            .foregroundColor(.red)
                    }
                    Button {
                        
                    } label: {
                        Image(systemName: "forward.circle.fill")
                            .scaleEffect(3)
                            .foregroundColor(.red)
                    }

                }.padding(.top, 50).padding(.bottom, 50)
                HStack {
                    Text("0:00")
                        .padding(.trailing, 15)
                    Image(systemName: "waveform")
                        .scaleEffect(3)
                        .padding(.trailing, 25)
                    Image(systemName: "waveform")
                        .scaleEffect(3)
                        .padding(.trailing, 25)
                    Image(systemName: "waveform")
                        .scaleEffect(3)
                        .padding(.trailing, 25)
                    Image(systemName: "waveform")
                        .scaleEffect(3)
                        .padding(.trailing, 25)
                    Image(systemName: "waveform")
                        .scaleEffect(3)
                        .padding(.trailing, 15)
                    Text(onlineSong.duration)
                    
                }.padding(.top, 30)
                
            }
        
    }
}

struct DetailedOnlineSongView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedOnlineSongView(onlineSong: OnlineSong(album: "", albumImageURL: "https://i.discogs.com/ib_5EAiVM8nkLgmHAq3vWyHBbRrMEaqkYsps2vUNr18/rs:fit/g:sm/q:90/h:599/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTE2Mjk1/MjA3LTE2MDY4OTIw/MDQtMTU0Ni5qcGVn.jpeg", artist: "Ba Boni", duration: "", name: "Cris123", year: 2018))
    }
}
