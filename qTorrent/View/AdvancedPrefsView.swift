//
//  AdvancedPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct AdvancedPrefsView: View {
    @State var recheckCompletedTorrents = false
    @State var resolvePeerCountrie = true
    @State var reannounceWhenAddressChanges = false
    @State var embeddedTracker = false
    @State var enableOSCache = true
    @State var coalesceReadsWrites = true
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("QBITTORRENT SECTION")) {
                    Text("Save Resume Data Interval (Min)").badge("60")
                    
                    Toggle(isOn: $recheckCompletedTorrents) {
                        Text("Recheck Completed Torrents")
                    }
                    .onChange(of: recheckCompletedTorrents) { newBool in
                        let prefs = [
                            "recheck_completed_torrents": newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                            await fetchPreferences()
                        }
                    }
                    
                    Toggle(isOn: $resolvePeerCountrie) {
                        Text("Resolve Peer Countries")
                    }
                    .onChange(of: resolvePeerCountrie) { newBool in
                        let prefs = [
                            "resolve_peer_countries": newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                            await fetchPreferences()
                        }
                    }
                    
                    Toggle(isOn: $reannounceWhenAddressChanges) {
                        Text("Reannounce When Address Changes")
                    }
                    .onChange(of: reannounceWhenAddressChanges) { newBool in
                        let prefs = [
                            "reannounce_when_address_changed": newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                            await fetchPreferences()
                        }
                    }
                    
                    Toggle(isOn: $embeddedTracker) {
                        Text("Embedded Tracker")
                    }
                    .onChange(of: embeddedTracker) { newBool in
                        let prefs = [
                            "enable_embedded_tracker": newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                            await fetchPreferences()
                        }
                    }
                    
                    Text("Embedded Tracker Port").badge("9000")
                }
                
                Section(header: Text("LIBTORRENT SECTION")) {
                    Text("Asynchronous IO Threads").badge("10")
                    
                    Text("Hashing Threads").badge("1")
                    
                    Text("File Pool Size").badge("5000")
                    
                    Toggle(isOn: $enableOSCache) {
                        Text("Enable OS Cache")
                    }
                    .onChange(of: enableOSCache) { newBool in
                        let prefs = [
                            "enable_os_cache": newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                            await fetchPreferences()
                        }
                    }
                    
                    Toggle(isOn: $coalesceReadsWrites) {
                        Text("Coalesce Reads & Writes")
                    }
                    .onChange(of: coalesceReadsWrites) { newBool in
                        let prefs = [
                            "enable_coalesce_read_write": newBool
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
        .navigationTitle("Advanced")
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
        recheckCompletedTorrents = preferences!.isRecheckCompletedTorrents
        resolvePeerCountrie = preferences!.isResolvePeerCountries
        reannounceWhenAddressChanges = preferences!.isReannounceWhenAddressChanged
        embeddedTracker = preferences!.isEnableEmbeddedTracker
        enableOSCache = preferences!.isEnableOSCache
        coalesceReadsWrites = preferences!.isEnableCoalesceReadWrite
    }
}
