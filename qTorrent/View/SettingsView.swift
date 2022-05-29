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
                Section(header: Text("REMOTE CLIENT")) {
                    NavigationLink(destination: DeferView {
                        AuthPrefsView()
                    }) {
                        Label("Authentication", systemImage: "lock.fill").labelStyle(ColorfulIconLabelStyle(color: Color(.systemPink), size: 1))
                    }
                    
                    NavigationLink(destination: DeferView {
                        ConfigPrefsView()
                    }) {
                        Label("Configuration", systemImage: "gearshape.2.fill").labelStyle(ColorfulIconLabelStyle(color: Color(.systemGray), size: 1))
                    }
                }
                
                Section(header: Text("Customization")) {
                    NavigationLink(destination: DeferView {
                        AppThemePrefsView()
                    }) {
                        Label("App Theme", systemImage: "paintbrush.fill").labelStyle(ColorfulIconLabelStyle(color: Color(.systemIndigo), size: 1))
                            .badge(Text(appTheme.rawValue))
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
