//
//  SpeedPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct SpeedPrefsView: View {
    var body: some View {
        VStack {
            List {
                Section(header: Text("GLOBAL RATE LIMITS")) {
                    Text("Upload (KiB/s)").badge("0")
                    Text("Download (KiB/s)").badge("0")
                }
                
                Section(header: Text("ALTERNATIVE RATE LIMITS")) {
                    Text("Upload (KiB/s)").badge("5000")
                    Text("Download (KiB/s)").badge("5000")
                }
            }
        }
        .navigationTitle("Speed")
        .navigationBarTitleDisplayMode(.inline)
    }
}
