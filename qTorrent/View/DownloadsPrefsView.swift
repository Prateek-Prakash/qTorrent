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
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("TORRENT ADDITION")) {
                    Toggle(isOn: $autoStartTorrent) {
                        Text("Auto Start Torrent")
                    }
                    
                    Toggle(isOn: $deleteTorrentAfter) {
                        Text("Delete Torrent After")
                    }
                }
            }
        }
        .navigationTitle("Downloads")
        .navigationBarTitleDisplayMode(.inline)
    }
}
