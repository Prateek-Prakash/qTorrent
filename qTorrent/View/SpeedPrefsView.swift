//
//  SpeedPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct SpeedPrefsView: View {
    @State var limitUTP = true
    @State var limitTCPOverhead = false
    @State var limitLANPeers = true
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("GLOBAL RATE LIMITS")) {
                    Text("Upload (KiB/s)").badge("0")
                    Text("Download (KiB/s)").badge("0")
                }
                
                Section(header: Text("ALTERNATIVE RATE LIMITS")) {
                    Text("Upload (KiB/s)").badge("5000")
                    Text("Download (KiB/s)").badge("5000")
                }
                
                Section(header: Text("RATE LIMITS SETTINGS")) {
                    Toggle(isOn: $limitUTP) {
                        Text("Apply Limit To μTP")
                    }
                    .onChange(of: limitUTP) { newBool in
                        let prefs = [
                            "limit_utp_rate": newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                            await fetchPreferences()
                        }
                    }
                    
                    Toggle(isOn: $limitTCPOverhead) {
                        Text("Apply Limit To TCP Overhead")
                    }
                    .onChange(of: limitTCPOverhead) { newBool in
                        let prefs = [
                            "limit_tcp_overhead": newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                            await fetchPreferences()
                        }
                    }
                    
                    Toggle(isOn: $limitLANPeers) {
                        Text("Apply Limit To Peers On LAN")
                    }
                    .onChange(of: limitLANPeers) { newBool in
                        let prefs = [
                            "limit_lan_peers": newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                            await fetchPreferences()
                        }
                    }
                }
            }
        }
        .navigationTitle("Speed")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await fetchPreferences()
            }
        }
    }
    
    // Functions
    
    func fetchPreferences() async {
        let preferences = await TorrentService.shared.getPreferences()
        limitUTP = preferences!.isLimitUTPRate
        limitTCPOverhead = preferences!.isLimitTCPOverhead
        limitLANPeers = preferences!.isLimitLANPeers
    }
}
