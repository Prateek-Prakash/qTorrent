//
//  ContentView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 7/6/22.
//

import SwiftUI

struct ContentView: View {
    let torrentHash: String
    
    var body: some View {
        VStack {
            VStack {
                Text("CONTENT VIEW")
            }
            .navigationTitle("Content")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
