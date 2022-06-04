//
//  SearchView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 6/3/22.
//

import SwiftUI

struct SearchView: View {
    @State private var searchId: Int? = nil
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
                                Image(systemName: "doc.plaintext.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18, alignment: .center)
                                    .padding()
                                
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(result.fileName.uppercased())
                                        .font(.system(size: 10, weight: .bold))
                                    
                                    HStack {
                                        HStack {
                                            Text("Seeders • \(result.seeders)")
                                                .font(.system(size: 10))
                                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        
                                        HStack {
                                            Text("Leechers • \(result.leechers)")
                                                .font(.system(size: 10))
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
            .onReceive(refreshTimer) { currTime in
                Task {
                    if searchId != nil && searchResults?.status != "Stopped" {
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
        if searchId != nil {
            await TorrentService.shared.stopSearch(searchId!)
            await TorrentService.shared.deleteSearch(searchId!)
            searchId = nil
            searchResults = nil
        }
    }
    
    func fetchSearchResults() async {
        if searchId != nil {
            if let results = await TorrentService.shared.getSearchResults(searchId!) {
                searchResults = results
            }
        }
    }
}
