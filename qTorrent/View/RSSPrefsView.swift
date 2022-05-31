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
                    .onChange(of: fetchRSSFeeds) { newBool in
                        let prefs = [
                            "rss_processing_enabled": newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                            await fetchPreferences()
                        }
                    }
                    
                    Text("Refresh Interval (Minutes)").badge("30")
                    
                    Text("Max Articles Per Feed").badge("50")
                }
                
                Section(header: Text("RSS AUTO DOWNLOADER")) {
                    Toggle(isOn: $autoDownloadRSSTorrents) {
                        Text("Auto Download RSS Torrents")
                    }
                    .onChange(of: autoDownloadRSSTorrents) { newBool in
                        let prefs = [
                            "rss_auto_downloading_enabled": newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                            await fetchPreferences()
                        }
                    }
                }
                
                Section(header: Text("RSS SMART EPISODE FILTER")) {
                    Toggle(isOn: $downloadRepackProperEpisodes) {
                        Text("Download REPACK•PROPER Episodes")
                    }
                    .onChange(of: downloadRepackProperEpisodes) { newBool in
                        let prefs = [
                            "rss_download_repack_proper_episodes": newBool
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
        .navigationTitle("RSS")
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
        fetchRSSFeeds = preferences!.isRSSProcessingEnabled
        autoDownloadRSSTorrents = preferences!.isRSSAutoDownloadingEnabled
        downloadRepackProperEpisodes = preferences!.isRSSDownloadRepackProperEpisodes
    }
}
