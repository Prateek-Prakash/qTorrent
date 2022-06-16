//
//  ConnectionPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import BetterListPicker
import SwiftUI

struct ConnectionPrefsView: View {
    @EnvironmentObject var configPrefaData: ConfigPrefsViewModel
    
    var body: some View {
        VStack {
            List {
                Section {
                    BetterListPicker("Peer Connection Protocol", selection: $configPrefaData.bitTorrentProtocol, pickerData: BitTorrentProtocol.allCases)
                        .onChange(of: configPrefaData.bitTorrentProtocol) { newValue in
                            let prefs = [
                                "bittorrent_protocol": newValue.indexValue
                            ]
                            Task {
                                await configPrefaData.updatePreferences(prefs)
                            }
                        }
                }
                
                Section(header: Text("LISTENTING PORT")) {
                    Text("Incoming Port").badge("54547")
                }
                
                Section(header: Text("CONNECTION LIMITS")) {
                    Text("Global Max Connections").badge("500")
                    Text("Max Connections Per Torrent").badge("100")
                    Text("Global Max Upload Slots").badge("8")
                    Text("Max Upload Slots Per Torrent").badge("4")
                }
            }
        }
        .navigationTitle("Connection")
        .navigationBarTitleDisplayMode(.inline)
    }
}
