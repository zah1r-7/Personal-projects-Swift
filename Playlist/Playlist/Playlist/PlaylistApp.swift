//
//  PlaylistApp.swift
//  Playlist
//
//  Created by Alumno on 09/08/23.
//

/*
 REYES SANCHEZ CRISTIAN ZAHIR
 */


import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       FirebaseApp.configure()
       return true
     }
}

@main
struct PlaylistApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            TabView {
                OnlinePlaylistView()
                    .tabItem {
                        Image(systemName: "music.note.list")
                        Text("Playlist")
                    }
                OnlineArtistsView()
                    .tabItem {
                        Image(systemName: "person.3.fill")
                        Text("Artists")
                    }
            }
        }
    }
}
