//
//  DownloadsPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct DownloadsPrefsView: View {
    @EnvironmentObject var configPrefaData: ConfigPrefsViewModel
    
    var body: some View {
        VStack {
            List {
                Toggle(isOn: $configPrefaData.preallocateDiskSpace) {
                    Text("Pre-Allocate Disk Space For Files")
                }
                .onChange(of: configPrefaData.preallocateDiskSpace) { newValue in
                    let prefs = [
                        "preallocate_all": newValue
                    ]
                    Task {
                        await configPrefaData.updatePreferences(prefs)
                    }
                }
                
                Toggle(isOn: $configPrefaData.appendIncompleteExtension) {
                    Text("Append !.qB For Incomplete Files")
                }
                .onChange(of: configPrefaData.appendIncompleteExtension) { newValue in
                    let prefs = [
                        "incomplete_files_ext": newValue
                    ]
                    Task {
                        await configPrefaData.updatePreferences(prefs)
                    }
                }
                
                Section(header: Text("TORRENT ADDITION")) {
                    Toggle(isOn: $configPrefaData.autoStartTorrent) {
                        Text("Auto Start Torrent")
                    }
                    .onChange(of: configPrefaData.autoStartTorrent) { newValue in
                        let prefs = [
                            "start_paused_enabled": !newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                    
                    Toggle(isOn: $configPrefaData.deleteTorrentAfter) {
                        Text("Delete Torrent After")
                    }
                    .onChange(of: configPrefaData.deleteTorrentAfter) { newValue in
                        let prefs = [
                            "auto_delete_mode": newValue ? 1 : 0
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                }
                
                Section(header: Text("TORRENT COMPLETION")) {
                    Toggle(isOn: $configPrefaData.runExternalProgram) {
                        Text("Run External Program")
                    }
                    .onChange(of: configPrefaData.runExternalProgram) { newValue in
                        let prefs = [
                            "autorun_enabled": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                }
            }
        }
        .navigationTitle("Downloads")
        .navigationBarTitleDisplayMode(.inline)
    }
}
