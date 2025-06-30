//
//  DetailedSongView.swift
//  Playlist
//
//  Created by Alumno on 09/08/23.
//

import SwiftUI

struct DetailedSongView: View {
    
    let song: Song
    @State var isPlaying: Bool = false
    
    var body: some View {
        
            ScrollView {
                Image(song.albumImage)
                    .resizable()
                    //.frame(width: 350, height: 350)
                    .scaledToFit()
                    .padding(.horizontal, 20)
                VStack(alignment: .leading) {
                    HStack {
                        Text(song.name)
                            .font(.headline)
                        Text(String("(\(song.year))"))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text(song.artist)
                            .font(.subheadline)
                        Spacer()
                        Text(song.album)
                            .font(.subheadline)
                    }
                }.padding(.leading, 25).padding(.trailing, 25)
                HStack(spacing: 50) {
                    Button {
                        //Lógica del backward
                    } label: {
                        Image(systemName: "backward.circle.fill")
                            .scaleEffect(3)
                            .foregroundColor(.red)
                    }
                    Button {
                        //Lógica de pausa
                        self.isPlaying.toggle()
                    } label: {
                        Image(systemName: self.isPlaying ? "pause.circle.fill":"play.circle.fill")
                            .scaleEffect(4)
                            .foregroundColor(.red)
                    }
                    Button {
                        //Lógica del forward
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
                    Text(song.duration)
                    
                }.padding(.top, 30)
                
            }
        
        
    }
}

struct DetailedSongView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        DetailedSongView(song: Song(name: "West Coast", year: 2018, album: "Origins", albumImage: "origins", artist: "Imagine Dragons", duration: "3:38"))
    }
}
