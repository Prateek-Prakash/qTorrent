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
    
    @State private var searchQuery = ""
    
    let refreshTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    if let torrents = filteredList {
                        ForEach(torrents.indices, id: \.self) { torrentIndex in
                            let torrent = torrents[torrentIndex]
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
                                }
                                .padding(.vertical)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 10))
                                    .foregroundColor(.secondary)
                                    .padding()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(5)
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
        }
        .onAppear {
            Task {
                await fetchTorrents()
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
}
