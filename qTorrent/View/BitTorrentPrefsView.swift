//
//  BitTorrentPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct BitTorrentPrefsView: View {
    @EnvironmentObject var configPrefaData: ConfigPrefsViewModel
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("PRIVACY")) {
                    Toggle(isOn: $configPrefaData.enableDHT) {
                        Text("Decentralized Network (DHT)")
                    }
                    .onChange(of: configPrefaData.enableDHT) { newValue in
                        let prefs = [
                            "dht": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                    
                    Toggle(isOn: $configPrefaData.enablePeX) {
                        Text("Peer Exchange (PeX)")
                    }
                    .onChange(of: configPrefaData.enablePeX) { newValue in
                        let prefs = [
                            "pex": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                    
                    Toggle(isOn: $configPrefaData.enableLSD) {
                        Text("Local Peer Discovery (LSD)")
                    }
                    .onChange(of: configPrefaData.enableLSD) { newValue in
                        let prefs = [
                            "lsd": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                    
                    Toggle(isOn: $configPrefaData.anonymousMode) {
                        Text("Anonymous Mode")
                    }
                    .onChange(of: configPrefaData.anonymousMode) { newValue in
                        let prefs = [
                            "anonymous_mode": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                }
            }
        }
        .navigationTitle("BitTorrent")
        .navigationBarTitleDisplayMode(.inline)
    }
}
