//
//  LogsPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct LogsPrefsView: View {
    var body: some View {
        VStack {
            List {
                Section(header: Text("TYPES")) {
                    NavigationLink(destination: DeferView {
                        MainLogsPrefsView()
                    }) {
                        Text("Main Logs")
                    }
                    
                    
                    NavigationLink(destination: DeferView {
                        PeerLogsPrefsView()
                    }) {
                        Text("Peer Logs")
                    }
                }
            }
        }
        .navigationTitle("Logs")
        .navigationBarTitleDisplayMode(.inline)
    }
}
