//
//  qTorrentApp.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

@main
struct qTorrentApp: App {
    @AppStorage("appTheme") var appTheme: AppTheme = .system
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(appTheme.colorScheme)
        }
    }
}
