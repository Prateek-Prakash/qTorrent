//
//  ContentView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var torrentsData = TorrentsViewModel()
    
    init() {
        // Rounded NavigationBar Title
        var titleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleFont = UIFont(
            descriptor:
                titleFont.fontDescriptor
                .withDesign(.rounded)?
                .withSymbolicTraits(.traitBold)
            ??
            titleFont.fontDescriptor,
            size: titleFont.pointSize
        )
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: titleFont]
        
        // Translucent TabBar
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        
        // Attempt Login
        Task {
            let getLogin = await TorrentService.shared.getLogin()
            debugPrint("Login Successful: \(getLogin!)")
        }
    }
    
    var body: some View {
        TabView {
            TorrentsView()
                .tabItem {
                    Image(systemName: "tray.2.fill")
                    Text("Torrents")
                }
                .environmentObject(torrentsData)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}
