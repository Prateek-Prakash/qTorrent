//
//  LogsPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct LogsPrefsView: View {
    @State var completeList: [MainLog]? = []
    @State var filteredList: [MainLog]? = []
    
    @State var displayeTypes = [ 1, 2, 3, 8 ]
    
    let refreshTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    if let logs = filteredList {
                        ForEach(logs.indices, id: \.self) { logIndex in
                            let log = logs[logIndex]
                            if displayeTypes.contains(log.type!) {
                                HStack(alignment: .center, spacing: 0) {
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text(String(log.getLogLevel()))
                                            .font(.system(size: 10, weight: .thin))
                                            .foregroundColor(log.getLogColor())
                                        
                                        Text(log.message!.uppercased())
                                            .font(.system(size: 10, weight: .bold))
                                        
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
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .navigationTitle("Logs")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Menu {
                Button {
                    if displayeTypes.contains(1) {
                        displayeTypes.remove(at: displayeTypes.firstIndex(of: 1)!)
                    } else {
                        displayeTypes.append(1)
                    }
                } label: {
                    Text("Normal").tag(1)
                    if displayeTypes.contains(1) {
                        Image(systemName: "checkmark")
                    }
                }
                
                Button {
                    if displayeTypes.contains(2) {
                        displayeTypes.remove(at: displayeTypes.firstIndex(of: 2)!)
                    } else {
                        displayeTypes.append(2)
                    }
                } label: {
                    Text("Info").tag(2)
                    if displayeTypes.contains(2) {
                        Image(systemName: "checkmark")
                    }
                }
                
                Button {
                    if displayeTypes.contains(3) {
                        displayeTypes.remove(at: displayeTypes.firstIndex(of: 3)!)
                    } else {
                        displayeTypes.append(3)
                    }
                } label: {
                    Text("Warning").tag(3)
                    if displayeTypes.contains(3) {
                        Image(systemName: "checkmark")
                    }
                }
                
                Button {
                    if displayeTypes.contains(8) {
                        displayeTypes.remove(at: displayeTypes.firstIndex(of: 8)!)
                    } else {
                        displayeTypes.append(8)
                    }
                } label: {
                    Text("Critical").tag(8)
                    if displayeTypes.contains(8) {
                        Image(systemName: "checkmark")
                    }
                }
            } label: {
                Label("Filter", systemImage: "slider.horizontal.3")
            }
        }
        .onAppear {
            Task {
                await fetchMainLogs()
            }
        }
        .onReceive(refreshTimer) { currTime in
            Task {
                await fetchMainLogs()
            }
        }
    }
    
    // Functions
    
    func fetchMainLogs() async {
        let mainLogs = await TorrentService.shared.getMainLogs()
        DispatchQueue.main.async {
            completeList = mainLogs
            filteredList = mainLogs
        }
    }
}
