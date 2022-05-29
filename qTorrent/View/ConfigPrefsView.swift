//
//  ConfigPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

struct ConfigPrefsView: View {
    var body: some View {
        VStack {
            List {
                Section(header: Text("OPTIONS CATEGORIES")) {
                    NavigationLink(destination: DeferView {
                        DownloadsPrefsView()
                    }) {
                        Text("Downloads")
                    }
                    
                    
                    NavigationLink(destination: DeferView {
                        ConnectionPrefsView()
                    }) {
                        Text("Connection")
                    }
                    
                    
                    NavigationLink(destination: DeferView {
                        SpeedPrefsView()
                    }) {
                        Text("Speed")
                    }
                    
                    
                    NavigationLink(destination: DeferView {
                        BitTorrentPrefsView()
                    }) {
                        Text("BitTorrent")
                    }
                    
                    NavigationLink(destination: DeferView {
                        RSSPrefsView()
                    }) {
                        Text("RSS")
                    }
                    
                    NavigationLink(destination: DeferView {
                        WebUIPrefsView()
                    }) {
                        Text("Web UI")
                    }
                    
                    
                    NavigationLink(destination: DeferView {
                        AdvancedPrefsView()
                    }) {
                        Text("Advanced")
                    }
                }
            }
        }
        .navigationTitle("Configuration")
        .navigationBarTitleDisplayMode(.inline)
    }
}
