//
//  TorrentsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

struct TorrentsView: View {
    @State var completeList: [Torrent]? = []
    @State var filteredList: [Torrent]? = []
    
    @State private var selectedState: Int = 1
    @State private var searchQuery = ""
    
    let refreshTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var speedLimitsEnabled = false
    
    @State var displayStates = [
        "error",
        "missingFiles",
        "uploading",
        "pausedUP",
        "queuedUP",
        "stalledUP",
        "checkingUP",
        "forcedUP",
        "allocating",
        "downloading",
        "metaDL",
        "pausedDL",
        "queuedDL",
        "stalledDL",
        "checkingDL",
        "forcedDL",
        "checkingResumeData",
        "moving",
        "unknown"
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    if let torrents = filteredList {
                        ForEach(torrents.indices, id: \.self) { torrentIndex in
                            let torrent = torrents[torrentIndex]
                            if displayStates.contains(torrent.state) {
                                HStack(alignment: .center, spacing: 0) {
                                    Button(action: {
                                        let canPause = torrent.canPause()
                                        let canResume = torrent.canResume()
                                        if canPause != nil && canPause! {
                                            Task {
                                                await TorrentService.shared.pause([torrent.hash])
                                            }
                                        } else if canResume != nil && canResume! {
                                            Task {
                                                await TorrentService.shared.resume([torrent.hash])
                                            }
                                        }
                                    }) {
                                        Image(systemName: torrent.getStateIcon())
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 18, height: 18, alignment: .center)
                                            .foregroundColor(torrent.getStateColor())
                                            .padding()
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text(torrent.name.uppercased())
                                            .font(.system(size: 10, weight: .bold))
                                        
                                        Text(torrent.hash.uppercased())
                                            .font(.system(size: 10, weight: .thin))
                                            .foregroundColor(.secondary)
                                        
                                        ProgressView(value: torrent.progress, total: 1)
                                        
                                        HStack {
                                            HStack {
                                                Image(systemName: "arrowtriangle.down.fill")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 8, height: 8, alignment: .center)
                                                Text("\(torrent.dlSpeed) B/s")
                                                    .font(.system(size: 10))
                                            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                            
                                            HStack {
                                                Image(systemName: "arrowtriangle.up.fill")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 8, height: 8, alignment: .center)
                                                Text("\(torrent.upSpeed) B/s")
                                                    .font(.system(size: 10))
                                            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                    .padding(.vertical)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 10, height: 10, alignment: .center)
                                        .foregroundColor(.secondary)
                                        .padding()
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(UIColor.secondarySystemBackground))
                                .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .searchable(text: $searchQuery, prompt: "Search")
            .autocapitalization(.words)
            .disableAutocorrection(true)
            .onChange(of: searchQuery) { searchQuery in
                if !searchQuery.isEmpty {
                    executeSearch()
                } else {
                    clearSearch()
                }
            }
            .navigationTitle("Torrents")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task {
                            await TorrentService.shared.toggleSpeedLimitsMode()
                            let speedLimitsMode = await TorrentService.shared.getSpeedLimitsMode()
                            if speedLimitsMode != nil {
                                speedLimitsEnabled = speedLimitsMode!
                            }
                        }
                    } label: {
                        if speedLimitsEnabled {
                            Image(systemName: "tortoise")
                        } else {
                            Image(systemName: "hare")
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Picker(selection: $selectedState, label: Text("Sorting options")) {
                            HStack {
                                Text("All")
                                Image(systemName: "circle.hexagongrid")
                            }.tag(1)
                            
                            HStack {
                                Text("Active")
                                Image(systemName: "arrow.up.arrow.down")
                            }.tag(2)
                            
                            HStack {
                                Text("Downloading")
                                Image(systemName: "arrow.down")
                            }.tag(3)
                            
                            HStack {
                                Text("Seeding")
                                Image(systemName: "arrow.up")
                            }.tag(4)
                            
                            HStack {
                                Text("Paused")
                                Image(systemName: "pause")
                            }.tag(5)
                            
                            HStack {
                                Text("Unknown")
                                Image(systemName: "questionmark")
                            }.tag(6)
                            
                            HStack {
                                Text("Errored")
                                Image(systemName: "exclamationmark")
                            }.tag(7)
                        }
                        .onChange(of: selectedState) { selectedTag in
                            updateDisplayStates()
                        }
                    } label: {
                        Label("Filter", systemImage: "slider.horizontal.3")
                    }
                }
            }
        }
        .onAppear {
            Task {
                await fetchTorrents()
                let speedLimitsMode = await TorrentService.shared.getSpeedLimitsMode()
                if speedLimitsMode != nil {
                    speedLimitsEnabled = speedLimitsMode!
                }
            }
        }
        .onReceive(refreshTimer) { currTime in
            Task {
                await fetchTorrents()
            }
        }
    }
    
    // Functions
    
    func fetchTorrents() async {
        let torrents = await TorrentService.shared.getTorrents()
        DispatchQueue.main.async {
            completeList = torrents
            if !searchQuery.isEmpty {
                executeSearch()
            } else {
                filteredList = torrents
            }
        }
    }
    
    func executeSearch() {
        DispatchQueue.main.async {
            filteredList = completeList?.filter { $0.name.uppercased().contains(searchQuery.uppercased()) }
        }
    }
    
    func clearSearch() {
        DispatchQueue.main.async {
            filteredList = completeList
        }
    }
    
    func updateDisplayStates() {
        switch selectedState {
        case 1:
            displayStates = [
                "error",
                "missingFiles",
                "uploading",
                "pausedUP",
                "queuedUP",
                "stalledUP",
                "checkingUP",
                "forcedUP",
                "allocating",
                "downloading",
                "metaDL",
                "pausedDL",
                "queuedDL",
                "stalledDL",
                "checkingDL",
                "forcedDL",
                "checkingResumeData",
                "moving",
                "unknown"
            ]
        case 2:
            displayStates = [
                "allocating",
                "downloading",
                "metaDL",
                "checkingDL",
                "forcedDL",
                "uploading",
                "checkingUP",
                "forcedUP"
            ]
        case 3:
            displayStates = [
                "allocating",
                "downloading",
                "metaDL",
                "queuedDL",
                "stalledDL",
                "checkingDL",
                "forcedDL"
            ]
        case 4:
            displayStates = [
                "uploading",
                "queuedUP",
                "stalledUP",
                "checkingUP",
                "forcedUP"
            ]
        case 5:
            displayStates = [
                "pausedUP",
                "pausedDL"
            ]
        case 6:
            displayStates = [
                "checkingResumeData",
                "moving",
                "unknown"
            ]
        case 7:
            displayStates = [
                "error",
                "missingFiles"
            ]
        default:
            break
        }
    }
}
