//
//  AdvancedPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct AdvancedPrefsView: View {
    @EnvironmentObject var configPrefaData: ConfigPrefsViewModel
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("QBITTORRENT SECTION")) {
                    Text("Save Resume Data Interval (Min)").badge("60")
                    
                    Toggle(isOn: $configPrefaData.recheckCompletedTorrents) {
                        Text("Recheck Completed Torrents")
                    }
                    .onChange(of: configPrefaData.recheckCompletedTorrents) { newValue in
                        let prefs = [
                            "recheck_completed_torrents": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                    
                    Toggle(isOn: $configPrefaData.resolvePeerCountrie) {
                        Text("Resolve Peer Countries")
                    }
                    .onChange(of: configPrefaData.resolvePeerCountrie) { newValue in
                        let prefs = [
                            "resolve_peer_countries": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                    
                    Toggle(isOn: $configPrefaData.reannounceWhenAddressChanges) {
                        Text("Reannounce When Address Changes")
                    }
                    .onChange(of: configPrefaData.reannounceWhenAddressChanges) { newValue in
                        let prefs = [
                            "reannounce_when_address_changed": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                    
                    Toggle(isOn: $configPrefaData.embeddedTracker) {
                        Text("Embedded Tracker")
                    }
                    .onChange(of: configPrefaData.embeddedTracker) { newValue in
                        let prefs = [
                            "enable_embedded_tracker": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                    
                    Text("Embedded Tracker Port").badge("9000")
                }
                
                Section(header: Text("LIBTORRENT SECTION")) {
                    Text("Asynchronous IO Threads").badge("10")
                    
                    Text("Hashing Threads").badge("1")
                    
                    Text("File Pool Size").badge("5000")
                    
                    Toggle(isOn: $configPrefaData.enableOSCache) {
                        Text("Enable OS Cache")
                    }
                    .onChange(of: configPrefaData.enableOSCache) { newValue in
                        let prefs = [
                            "enable_os_cache": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                    
                    Toggle(isOn: $configPrefaData.coalesceReadsWrites) {
                        Text("Coalesce Reads & Writes")
                    }
                    .onChange(of: configPrefaData.coalesceReadsWrites) { newValue in
                        let prefs = [
                            "enable_coalesce_read_write": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                    
                    Toggle(isOn: $configPrefaData.usePieceExtentAffinity) {
                        Text("Use Piece Extent Affinity")
                    }
                    .onChange(of: configPrefaData.usePieceExtentAffinity) { newValue in
                        let prefs = [
                            "enable_piece_extent_affinity": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                    
                    Toggle(isOn: $configPrefaData.sendUploadPieceSuggestions) {
                        Text("Send Upload Piece Suggestions")
                    }
                    .onChange(of: configPrefaData.sendUploadPieceSuggestions) { newValue in
                        let prefs = [
                            "enable_upload_suggestions": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                }
            }
        }
        .navigationTitle("Advanced")
        .navigationBarTitleDisplayMode(.inline)
    }
}
