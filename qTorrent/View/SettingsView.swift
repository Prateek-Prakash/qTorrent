//
//  SettingsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import BetterListPicker
import SwiftUI

struct SettingsView: View {
    @AppStorage("appTheme") var appTheme: AppTheme = .system
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("QBITTORRENT")) {
                    NavigationLink(destination: DeferView {
                        AuthPrefsView()
                    }) {
                        Label("Authentication", systemImage: "lock.fill").labelStyle(ColorfulIconLabelStyle(color: Color(.systemTeal), size: 1))
                    }
                    
                    NavigationLink(destination: DeferView {
                        LogsPrefsView()
                    }) {
                        Label("Logs", systemImage: "doc.text.fill").labelStyle(ColorfulIconLabelStyle(color: Color(.systemOrange), size: 1))
                    }
                    
                    NavigationLink(destination: DeferView {
                        PluginsPrefsView()
                    }) {
                        Label("Search Plugins", systemImage: "magnifyingglass").labelStyle(ColorfulIconLabelStyle(color: Color(.systemPurple), size: 1))
                    }
                    
                    NavigationLink(destination: DeferView {
                        ConfigPrefsView().environmentObject(ConfigPrefsViewModel())
                    }) {
                        Label("Configuration", systemImage: "gearshape.2.fill").labelStyle(ColorfulIconLabelStyle(color: Color(.systemGray), size: 1))
                    }
                }
                
                Section(header: Text("QTORRENT")) {
                    BetterListPicker($appTheme, pickerData: AppTheme.allCases) {
                        Text("App Theme")
                    } label: {
                        Label("App Theme", systemImage: "paintbrush.fill").labelStyle(ColorfulIconLabelStyle(color: Color(.systemIndigo), size: 1))
                    }
                    
                    NavigationLink(destination: DeferView {
                        NotificationsPrefsView()
                    }) {
                        Label("Notifications", systemImage: "bell.badge.fill").labelStyle(ColorfulIconLabelStyle(color: Color(.systemRed), size: 1))
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
