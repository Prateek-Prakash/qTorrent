//
//  MainView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

struct MainView: View {
    @AppStorage("searchId") private var searchId = -1
    
    init() {
        // Translucent TabBar
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        
        // Attempt Login
        Task {
            await TorrentService.shared.login()
        }
    }
    
    var body: some View {
        TabView {
            TorrentsView()
                .tabItem {
                    Image(systemName: "tray.2.fill")
                    Text("Torrents")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .onAppear {
            Task {
                if searchId != -1 {
                    await TorrentService.shared.stopSearch(searchId)
                    await TorrentService.shared.deleteSearch(searchId)
                }
            }
        }
    }
}
