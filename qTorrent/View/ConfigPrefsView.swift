//
//  ConfigPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

struct ConfigPrefsView: View {
    @EnvironmentObject var configPrefaData: ConfigPrefsViewModel
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("CATEGORIES")) {
                    NavigationLink(destination: DeferView {
                        DownloadsPrefsView().environmentObject(configPrefaData)
                    }) {
                        Text("Downloads")
                    }
                    
                    NavigationLink(destination: DeferView {
                        ConnectionPrefsView().environmentObject(configPrefaData)
                    }) {
                        Text("Connection")
                    }
                    
                    NavigationLink(destination: DeferView {
                        SpeedPrefsView().environmentObject(configPrefaData)
                    }) {
                        Text("Speed")
                    }
                    
                    NavigationLink(destination: DeferView {
                        BitTorrentPrefsView().environmentObject(configPrefaData)
                    }) {
                        Text("BitTorrent")
                    }
                    
                    NavigationLink(destination: DeferView {
                        RSSPrefsView().environmentObject(configPrefaData)
                    }) {
                        Text("RSS")
                    }
                    
                    NavigationLink(destination: DeferView {
                        WebUIPrefsView().environmentObject(configPrefaData)
                    }) {
                        Text("Web UI")
                    }
                    
                    NavigationLink(destination: DeferView {
                        AdvancedPrefsView().environmentObject(configPrefaData)
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
