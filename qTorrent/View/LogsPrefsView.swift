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
    
    @State var displayNormal = true
    @State var displayInfo = true
    @State var displayWarning = true
    @State var displayCritical = true
    
    let refreshTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    if let logs = filteredList {
                        ForEach(logs.indices, id: \.self) { logIndex in
                            let log = logs[logIndex]
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
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .navigationTitle("Logs")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Menu {
                Button {
                    displayNormal.toggle()
                } label: {
                    Text("Normal").tag(1)
                    if displayNormal {
                        Image(systemName: "checkmark")
                    }
                }
                
                Button {
                    displayInfo.toggle()
                } label: {
                    Text("Info").tag(2)
                    if displayInfo {
                        Image(systemName: "checkmark")
                    }
                }
                
                Button {
                    displayWarning.toggle()
                } label: {
                    Text("Warning").tag(3)
                    if displayWarning {
                        Image(systemName: "checkmark")
                    }
                }
                
                Button {
                    displayCritical.toggle()
                } label: {
                    Text("Critical").tag(8)
                    if displayCritical {
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
