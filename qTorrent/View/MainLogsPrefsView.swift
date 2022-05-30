//
//  MainLogsPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/30/22.
//

import SwiftUI

struct MainLogsPrefsView: View {
    @State var completeList: [MainLog]? = []
    @State var filteredList: [MainLog]? = []
    
    @State var displayTypes = [ 1, 2, 3, 8 ]
    
    let refreshTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    if let logs = filteredList {
                        ForEach(logs.indices, id: \.self) { logIndex in
                            let log = logs[logIndex]
                            if displayTypes.contains(log.type) {
                                HStack(alignment: .center, spacing: 0) {
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text(String(log.getLogLevel()))
                                            .font(.system(size: 10, weight: .thin))
                                            .foregroundColor(log.getLogColor())
                                        
                                        Text(log.message.uppercased())
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
        .navigationTitle("Main Logs")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Menu {
                Button {
                    if displayTypes.contains(1) {
                        displayTypes.remove(at: displayTypes.firstIndex(of: 1)!)
                    } else {
                        displayTypes.append(1)
                    }
                } label: {
                    Text("Normal").tag(1)
                    if displayTypes.contains(1) {
                        Image(systemName: "checkmark")
                    }
                }
                
                Button {
                    if displayTypes.contains(2) {
                        displayTypes.remove(at: displayTypes.firstIndex(of: 2)!)
                    } else {
                        displayTypes.append(2)
                    }
                } label: {
                    Text("Info").tag(2)
                    if displayTypes.contains(2) {
                        Image(systemName: "checkmark")
                    }
                }
                
                Button {
                    if displayTypes.contains(3) {
                        displayTypes.remove(at: displayTypes.firstIndex(of: 3)!)
                    } else {
                        displayTypes.append(3)
                    }
                } label: {
                    Text("Warning").tag(3)
                    if displayTypes.contains(3) {
                        Image(systemName: "checkmark")
                    }
                }
                
                Button {
                    if displayTypes.contains(8) {
                        displayTypes.remove(at: displayTypes.firstIndex(of: 8)!)
                    } else {
                        displayTypes.append(8)
                    }
                } label: {
                    Text("Critical").tag(8)
                    if displayTypes.contains(8) {
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
