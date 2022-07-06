//
//  PieceMapView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 6/3/22.
//

import SwiftUI

struct PieceMapView: View {
    let torrentHash: String
    
    @State var completeList: [Piece]? = []
    
    let refreshTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 20, maximum: 20), spacing: 3)], spacing: 3) {
                    ForEach(completeList!.indices, id: \.self) { pieceIndex in
                        Rectangle()
                            .foregroundColor(completeList![pieceIndex].getStateColor())
                            .frame(width: 20, height: 20)
                            .mask(RoundedRectangle(cornerRadius: 3))
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("Piece Map")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            Task {
                await fetchPieceStates()
            }
        }
        .onReceive(refreshTimer) { currTime in
            Task {
                await fetchPieceStates()
            }
        }
    }
    
    // Functions
    
    func fetchPieceStates() async {
        let pieceStates = await TorrentService.shared.getPieceStates(torrentHash)
        completeList = pieceStates
    }
}
