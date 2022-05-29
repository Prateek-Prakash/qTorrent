//
//  ConnectionPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct ConnectionPrefsView: View {
    
    
    var body: some View {
        VStack {
            List {
                Section {
                    Text("Peer Connection Protocol").badge("TCP & μTP")
                }
                
                
                Section(header: Text("LISTENTING PORT")) {
                    Text("Incoming Port").badge("TCP & μTP")
                }
            }
        }
        .navigationTitle("Connection")
        .navigationBarTitleDisplayMode(.inline)
    }
}
