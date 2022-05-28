//
//  SettingsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("appTheme") var appTheme: AppTheme = .system
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Remote Client")) {
                    Text("Authentication")
                    Text("Preferences")
                }
                
                Section(header: Text("Customization")) {
                    NavigationLink(destination: DeferView {
                        AppThemePrefsView()
                    }) {
                        Text("App Theme")
                            .badge(Text(appTheme.rawValue))
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
