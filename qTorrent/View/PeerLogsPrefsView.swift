//
//  PeerLogsPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/30/22.
//

import SwiftUI

struct PeerLogsPrefsView: View {
    @State var completeList: [PeerLog]? = []
    
    let refreshTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    if let logs = completeList {
                        ForEach(logs.indices, id: \.self) { logIndex in
                            let log = logs[logIndex]
                            HStack(alignment: .center, spacing: 0) {
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(log.ip.uppercased())
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(log.getLogColor())
                                    
                                    Text(String(log.getDate()))
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(.secondary)
                                }
                                .padding(.horizontal)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .navigationTitle("Peer Logs")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await fetchPeerLogs()
            }
        }
        .onReceive(refreshTimer) { currTime in
            Task {
                await fetchPeerLogs()
            }
        }
    }
    
    // Functions
    
    func fetchPeerLogs() async {
        let peerLogs = await TorrentService.shared.getPeerLogs()
        DispatchQueue.main.async {
            completeList = peerLogs
        }
    }
}
