//
//  DetailsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 7/6/22.
//

import SwiftUI

struct DetailsView: View {
    let torrentHash: String
    
    var body: some View {
        VStack {
            List {
                NavigationLink(destination: DeferView {
                    PieceMapView(torrentHash: torrentHash)
                }) {
                    Text("Piece Map")
                }
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
