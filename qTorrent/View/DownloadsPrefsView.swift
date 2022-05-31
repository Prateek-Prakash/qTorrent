//
//  DownloadsPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct DownloadsPrefsView: View {
    @State var autoStartTorrent = true
    @State var deleteTorrentAfter = true
    
    let refreshTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("TORRENT ADDITION")) {
                    Toggle(isOn: $autoStartTorrent) {
                        Text("Auto Start Torrent")
                    }
                    .onChange(of: autoStartTorrent) { newBool in
                        let prefs = [
                            "start_paused_enabled": !newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                        }
                    }
                    
                    Toggle(isOn: $deleteTorrentAfter) {
                        Text("Delete Torrent After")
                    }
                    .onChange(of: deleteTorrentAfter) { newBool in
                        let prefs = [
                            "auto_delete_mode": newBool ? 1 : 0
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
        .navigationTitle("Downloads")
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
        autoStartTorrent = !preferences!.isStartPausedEnabled
        deleteTorrentAfter = preferences!.autoDeleteMode == 1 ? true : false
    }
}
