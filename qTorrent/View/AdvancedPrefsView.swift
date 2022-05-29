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
                    
                    Toggle(isOn: $resolvePeerCountrie) {
                        Text("Resolve Peer Countries")
                    }
                    
                    Toggle(isOn: $embeddedTracker) {
                        Text("Embedded Tracker")
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
                    
                    Toggle(isOn: $coalesceReadsWrites) {
                        Text("Coalesce Reads & Writes")
                    }
                }
            }
        }
        .navigationTitle("Advanced")
        .navigationBarTitleDisplayMode(.inline)
    }
}
