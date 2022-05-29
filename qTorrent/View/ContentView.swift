//
//  ContentView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

struct ContentView: View {
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
    }
    
    var body: some View {
        TabView {
            TorrentsView()
                .tabItem {
                    Image(systemName: "tray.2.fill")
                    Text("Torrents")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}
