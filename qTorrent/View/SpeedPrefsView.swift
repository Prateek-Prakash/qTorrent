//
//  SpeedPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct SpeedPrefsView: View {
    @EnvironmentObject var configPrefaData: ConfigPrefsViewModel
    
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
                    Toggle(isOn: $configPrefaData.limitUTP) {
                        Text("Apply Limit To μTP")
                    }
                    .onChange(of: configPrefaData.limitUTP) { newValue in
                        let prefs = [
                            "limit_utp_rate": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                    
                    Toggle(isOn: $configPrefaData.limitTCPOverhead) {
                        Text("Apply Limit To TCP Overhead")
                    }
                    .onChange(of: configPrefaData.limitTCPOverhead) { newValue in
                        let prefs = [
                            "limit_tcp_overhead": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                    
                    Toggle(isOn: $configPrefaData.limitLANPeers) {
                        Text("Apply Limit To Peers On LAN")
                    }
                    .onChange(of: configPrefaData.limitLANPeers) { newValue in
                        let prefs = [
                            "limit_lan_peers": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                }
            }
        }
        .navigationTitle("Speed")
        .navigationBarTitleDisplayMode(.inline)
    }
}
