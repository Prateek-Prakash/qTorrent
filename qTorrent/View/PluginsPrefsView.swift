//
//  PluginsPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 6/3/22.
//

import SwiftUI

struct PluginsPrefsView: View {
    @State var enable1337x = true
    @State var enableIPTorrents = true
    @State var enableYTSMX = true
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("PROVIDERS")) {
                    Toggle(isOn: $enable1337x) {
                        Text("1337x")
                    }
                    
                    Toggle(isOn: $enableIPTorrents) {
                        Text("IPTorrents")
                    }
                    
                    Toggle(isOn: $enableYTSMX) {
                        Text("YTS.MX")
                    }
                }
            }
        }
        .navigationTitle("Search Plugins")
        .navigationBarTitleDisplayMode(.inline)
    }
}
