//
//  RSSPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct RSSPrefsView: View {
    @State var fetchRSSFeeds = false
    @State var autoDownloadRSSTorrents = false
    @State var downloadRepackProperEpisodes = true
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("RSS READER")) {
                    Toggle(isOn: $fetchRSSFeeds) {
                        Text("Fetch RSS Feeds")
                    }
                    
                    Text("Refresh Interval (Minutes)").badge("30")
                    
                    Text("Max Articles Per Feed").badge("50")
                }
                
                Section(header: Text("RSS AUTO DOWNLOADER")) {
                    Toggle(isOn: $autoDownloadRSSTorrents) {
                        Text("Auto Download RSS Torrents")
                    }
                }
                
                Section(header: Text("RSS SMART EPISODE FILTER")) {
                    Toggle(isOn: $downloadRepackProperEpisodes) {
                        Text("Download REPACK|PROPER EPISODES")
                    }
                }
            }
        }
        .navigationTitle("RSS")
        .navigationBarTitleDisplayMode(.inline)
    }
}
