//
//  SearchView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 6/3/22.
//

import SwiftUI

struct SearchView: View {
    @AppStorage("searchId") private var searchId = -1
    @State private var searchQuery = ""
    @State private var searchResults: SearchResults? = nil
    
    let refreshTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    if let results = searchResults?.results {
                        ForEach(results.indices, id: \.self) { resultIndex in
                            let result = results[resultIndex]
                            HStack(alignment: .center, spacing: 0) {
                                Button(action: {
                                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                                }) {
                                    Image(systemName: "tray.and.arrow.down.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 18, height: 18, alignment: .center)
                                        .padding()
                                }
                                
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(result.fileName.uppercased())
                                        .font(.system(size: 10, weight: .bold))
                                    
                                    HStack(spacing: 0) {
                                        HStack {
                                            Text("Seeders • \(result.seeders)")
                                                .font(.system(size: 10, weight: .bold))
                                                .foregroundColor(Color(.systemGray))
                                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        
                                        HStack {
                                            Text("Leechers • \(result.leechers)")
                                                .font(.system(size: 10, weight: .bold))
                                                .foregroundColor(Color(.systemGray))
                                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        
                                        HStack {
                                            Text("Size • \(result.getFileSizeString())")
                                                .font(.system(size: 10, weight: .bold))
                                                .foregroundColor(Color(.systemGray))
                                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                .padding(.vertical)
                                .padding(.trailing)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("Search")
            .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .autocapitalization(.words)
            .disableAutocorrection(true)
            .onSubmit(of: .search) {
                Task {
                    await startSearch()
                }
            }
            .onChange(of: searchQuery) { searchQuery in
                if searchQuery.isEmpty {
                    Task {
                        await resetSearch()
                    }
                }
            }
            .onReceive(refreshTimer) { currTime in
                Task {
                    if searchId != -1 && searchResults?.status != "Stopped" {
                        await fetchSearchResults()
                    }
                }
            }
        }
    }
    
    // Functions
    
    func startSearch() async {
        await resetSearch()
            
        if let startSearch = await TorrentService.shared.startSearch(self.searchQuery) {
            searchId = startSearch.id
            await fetchSearchResults()
        }
    }
    
    func resetSearch() async {
        if searchId != -1 {
            await TorrentService.shared.stopSearch(searchId)
            await TorrentService.shared.deleteSearch(searchId)
            searchId = -1
            searchResults = nil
        }
    }
    
    func fetchSearchResults() async {
        if searchId != -1 {
            if let results = await TorrentService.shared.getSearchResults(searchId) {
                searchResults = results
            }
        }
    }
}
