//
//  DownloadsPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct DownloadsPrefsView: View {
    @State var preallocateDiskSpace = false
    @State var appendIncompleteExtension = true
    @State var autoStartTorrent = true
    @State var deleteTorrentAfter = true
    @State var runExternalProgram = false
    
    var body: some View {
        VStack {
            List {
                Toggle(isOn: $preallocateDiskSpace) {
                    Text("Pre-Allocate Disk Space For Files")
                }
                .onChange(of: preallocateDiskSpace) { newBool in
                    let prefs = [
                        "preallocate_all": newBool
                    ]
                    let json = try? JSONSerialization.data(withJSONObject: prefs)
                    let string = String(data: json!, encoding: String.Encoding.ascii)
                    Task {
                        await TorrentService.shared.setPreferences(string!)
                        await fetchPreferences()
                    }
                }
                
                Toggle(isOn: $appendIncompleteExtension) {
                    Text("Append !.qB For Incomplete Files")
                }
                .onChange(of: appendIncompleteExtension) { newBool in
                    let prefs = [
                        "incomplete_files_ext": newBool
                    ]
                    let json = try? JSONSerialization.data(withJSONObject: prefs)
                    let string = String(data: json!, encoding: String.Encoding.ascii)
                    Task {
                        await TorrentService.shared.setPreferences(string!)
                        await fetchPreferences()
                    }
                }
                
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
                            await fetchPreferences()
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
                            await fetchPreferences()
                        }
                    }
                }
                
                Section(header: Text("TORRENT COMPLETION")) {
                    Toggle(isOn: $runExternalProgram) {
                        Text("Run External Program")
                    }
                    .onChange(of: runExternalProgram) { newBool in
                        let prefs = [
                            "autorun_enabled": newBool
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
        .navigationTitle("Downloads")
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
        preallocateDiskSpace = preferences!.isPreallocateAll
        appendIncompleteExtension = preferences!.isIncompleteFilesExt
        autoStartTorrent = !preferences!.isStartPausedEnabled
        deleteTorrentAfter = preferences!.autoDeleteMode == 1 ? true : false
    }
}
