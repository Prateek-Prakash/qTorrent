//
//  SearchView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 6/3/22.
//

import SwiftUI

struct SearchView: View {
    @State private var searchQuery = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                
            }
            .navigationTitle("Search")
            .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .autocapitalization(.words)
            .disableAutocorrection(true)
        }
    }
}
