//
//  TorrentsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

struct TorrentsView: View {
    @EnvironmentObject var torrentsData: TorrentsViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    if let filterList = torrentsData.filterList {
                        ForEach(filterList.indices, id: \.self) { torrentIndex in
                            let torrentInfo = filterList[torrentIndex]
                            HStack(alignment: .center) {
                                VStack(alignment: .leading, spacing: 3.0) {
                                    Text(torrentInfo.name.uppercased())
                                        .font(.system(size: 10))
                                        .fontWeight(.bold)
                                        .bold()
                                    Text(torrentInfo.hash.uppercased())
                                        .font(.system(size: 10))
                                        .fontWeight(.thin)
                                        .foregroundColor(.secondary)
                                }
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
            .searchable(text: $torrentsData.searchQuery, prompt: "Search")
            .autocapitalization(.words)
            .disableAutocorrection(true)
            .onChange(of: torrentsData.searchQuery) { searchQuery in
                if !searchQuery.isEmpty {
                    torrentsData.executeSearch()
                } else {
                    torrentsData.clearSearch()
                }
            }
            .navigationTitle("Torrents")
        }
    }
}
