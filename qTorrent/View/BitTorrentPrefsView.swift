//
//  BitTorrentPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct BitTorrentPrefsView: View {
    @State var enableDHT = true
    @State var enablePeX = true
    @State var enableLSD = true
    @State var anonymousMode = false
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("PRIVACY")) {
                    Toggle(isOn: $enableDHT) {
                        Text("Decentralized Network (DHT)")
                    }
                    
                    Toggle(isOn: $enablePeX) {
                        Text("Peer Exchange (PeX)")
                    }
                    
                    Toggle(isOn: $enableLSD) {
                        Text("Local Peer Discovery (LSD)")
                    }
                    
                    Toggle(isOn: $anonymousMode) {
                        Text("Anonymous Mode")
                    }
                }
            }
        }
        .navigationTitle("BitTorrent")
        .navigationBarTitleDisplayMode(.inline)
    }
}
