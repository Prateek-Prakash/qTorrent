//
//  TorrentsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

struct TorrentsView: View {
    @EnvironmentObject var torrentsData: TorrentsViewModel
    
    
    @State private var searchQuery = ""
    @State private var editMode = EditMode.inactive
    
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
                                        .font(.system(size: 10, weight: .bold))
                                    
                                    Text(torrentInfo.hash.uppercased())
                                        .font(.system(size: 10, weight: .thin))
                                        .foregroundColor(.secondary)
                                }
                                .padding(.leading)
                                .padding(.vertical)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 10))
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
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
                    torrentsData.executeSearch(searchQuery)
                } else {
                    torrentsData.clearSearch()
                }
            }
            .navigationBarItems(leading: EditButton())
            .environment(\.editMode, $editMode)
            .navigationTitle("Torrents")
        }
    }
}
