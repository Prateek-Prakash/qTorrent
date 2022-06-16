//
//  RSSPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct RSSPrefsView: View {
    @EnvironmentObject var configPrefaData: ConfigPrefsViewModel
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("RSS READER")) {
                    Toggle(isOn: $configPrefaData.fetchRSSFeeds) {
                        Text("Fetch RSS Feeds")
                    }
                    .onChange(of: configPrefaData.fetchRSSFeeds) { newValue in
                        let prefs = [
                            "rss_processing_enabled": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                    
                    Text("Refresh Interval (Minutes)").badge("30")
                    
                    Text("Max Articles Per Feed").badge("50")
                }
                
                Section(header: Text("RSS AUTO DOWNLOADER")) {
                    Toggle(isOn: $configPrefaData.autoDownloadRSSTorrents) {
                        Text("Auto Download RSS Torrents")
                    }
                    .onChange(of: configPrefaData.autoDownloadRSSTorrents) { newValue in
                        let prefs = [
                            "rss_auto_downloading_enabled": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                }
                
                Section(header: Text("RSS SMART EPISODE FILTER")) {
                    Toggle(isOn: $configPrefaData.downloadRepackProperEpisodes) {
                        Text("Download REPACK•PROPER Episodes")
                    }
                    .onChange(of: configPrefaData.downloadRepackProperEpisodes) { newValue in
                        let prefs = [
                            "rss_download_repack_proper_episodes": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                }
            }
        }
        .navigationTitle("RSS")
        .navigationBarTitleDisplayMode(.inline)
    }
}
