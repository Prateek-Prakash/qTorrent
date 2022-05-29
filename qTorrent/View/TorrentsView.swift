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
                    if let torrentList = torrentsData.torrentList {
                        ForEach(torrentList.indices, id: \.self) { torrentIndex in
                            let torrentInfo = torrentList[torrentIndex]
                            HStack(alignment: .center) {
                                VStack(alignment: .leading, spacing: 3.0) {
                                    Text(torrentInfo.name!)
                                        .font(.headline)
                                        .bold()
                                    Text(torrentInfo.hash!)
                                        .font(.subheadline)
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
            .navigationTitle("Torrents")
        }
    }
}
