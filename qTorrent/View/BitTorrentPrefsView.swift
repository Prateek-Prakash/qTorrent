//
//  BitTorrentPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct BitTorrentPrefsView: View {
    @State var enableDHT = true
    @State var enablePeX = true
    @State var enableLSD = true
    @State var anonymousMode = false
    
    let refreshTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("PRIVACY")) {
                    Toggle(isOn: $enableDHT) {
                        Text("Decentralized Network (DHT)")
                    }
                    .onChange(of: enableDHT) { newBool in
                        let prefs = [
                            "dht": newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                        }
                    }
                    
                    Toggle(isOn: $enablePeX) {
                        Text("Peer Exchange (PeX)")
                    }
                    .onChange(of: enablePeX) { newBool in
                        let prefs = [
                            "pex": newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                        }
                    }
                    
                    Toggle(isOn: $enableLSD) {
                        Text("Local Peer Discovery (LSD)")
                    }
                    .onChange(of: enableLSD) { newBool in
                        let prefs = [
                            "lsd": newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                        }
                    }
                    
                    Toggle(isOn: $anonymousMode) {
                        Text("Anonymous Mode")
                    }
                    .onChange(of: anonymousMode) { newBool in
                        let prefs = [
                            "anonymous_mode": newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                        }
                    }
                }
            }
        }
        .navigationTitle("BitTorrent")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await fetchPreferences()
            }
        }
        .onReceive(refreshTimer) { currTime in
            Task {
                await fetchPreferences()
            }
        }
    }
    
    // Functions
    
    func fetchPreferences() async {
        let preferences = await TorrentService.shared.getPreferences()
        enableDHT = preferences!.isDHT
        enablePeX = preferences!.isPeX
        enableLSD = preferences!.isLSD
        anonymousMode = preferences!.isAnonymousMode
    }
}
