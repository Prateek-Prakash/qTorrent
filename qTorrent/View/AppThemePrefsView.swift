//
//  AppThemePrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

struct AppThemePrefsView: View {
    var appThemeOptions: [String] = ["System", "Dark", "Light"]
    @AppStorage("appTheme") var appTheme: AppTheme = .system
    
    var body: some View {
        VStack {
            List {
                Section {
                    ForEach(appThemeOptions, id: \.self) { appThemeOption in
                        Button(action: {
                            appTheme = AppTheme(rawValue: appThemeOption)!
                        }) {
                            Text(appThemeOption).badge(
                                Text("\(Image(systemName: appTheme.rawValue == appThemeOption ? "checkmark.circle.fill" : "circle"))")
                                    .foregroundColor(appTheme.rawValue == appThemeOption ? .accentColor : .primary)
                            ).foregroundColor(.primary)
                        }
                    }
                }
            }
        }
        .navigationTitle("App Theme")
        .navigationBarTitleDisplayMode(.inline)
    }
}
