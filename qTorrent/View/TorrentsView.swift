//
//  TorrentsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

struct TorrentsView: View {
    @State var torrentList: [TorrentInfo]? = []
    @State var filterList: [TorrentInfo]? = []
    
    @State private var searchQuery = ""
    
    @State private var editMode = EditMode.inactive
    
    let refreshTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    if let filterList = filterList {
                        ForEach(filterList.indices, id: \.self) { torrentIndex in
                            let torrentInfo = filterList[torrentIndex]
                            HStack(alignment: .center) {
                                Image(systemName: torrentInfo.getStateIcon())
                                    .font(.system(size: 15))
                                    .foregroundColor(torrentInfo.getStateColor())
                                    .padding()
                                
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(torrentInfo.name.uppercased())
                                        .font(.system(size: 10, weight: .bold))
                                    
                                    Text(torrentInfo.hash.uppercased())
                                        .font(.system(size: 10, weight: .thin))
                                        .foregroundColor(.secondary)
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
                    self.executeSearch(searchQuery)
                } else {
                    self.clearSearch()
                }
            }
            .navigationBarItems(leading: EditButton())
            .environment(\.editMode, $editMode)
            .navigationTitle("Torrents")
        }
        .onAppear {
            Task {
                let getLogin = await TorrentService.shared.getLogin()
                debugPrint("Login Successful: \(getLogin!)")
                await self.getTorrentsInfo()
            }
        }
        .onReceive(refreshTimer) { currTime in
            Task {
                await self.getTorrentsInfo()
            }
        }
    }
    
    // Functions
    
    func getTorrentsInfo() async {
        let torrentsInfo = await TorrentService.shared.getTorrentList()
        DispatchQueue.main.async {
            self.torrentList = torrentsInfo
            self.filterList = self.torrentList
        }
    }
    
    func executeSearch(_ searchQuery: String) {
        DispatchQueue.main.async {
            self.filterList = self.torrentList?.filter { $0.name.uppercased().contains(searchQuery.uppercased()) }
        }
    }
    
    func clearSearch() {
        DispatchQueue.main.async {
            self.filterList = self.torrentList
        }
    }
}
