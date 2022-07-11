//
//  qTorrentApp.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

@main
struct qTorrentApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @AppStorage("appTheme") var appTheme: AppTheme = .system
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(appTheme.colorScheme)
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
