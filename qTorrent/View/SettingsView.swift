//
//  SettingsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Remote Client")) {
                    Text("Authentication")
                    Text("Preferences")
                }
            }
            .navigationTitle("Settings")
        }
    }
}
