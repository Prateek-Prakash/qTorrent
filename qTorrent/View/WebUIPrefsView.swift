//
//  WebUIPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct WebUIPrefsView: View {
    @EnvironmentObject var configPrefaData: ConfigPrefsViewModel
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("SECURITY")) {
                    Toggle(isOn: $configPrefaData.clickjackingProtection) {
                        Text("Clickjacking Protection")
                    }
                    .onChange(of: configPrefaData.clickjackingProtection) { newValue in
                        let prefs = [
                            "web_ui_clickjacking_protection_enabled": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                    
                    Toggle(isOn: $configPrefaData.csrfProtection) {
                        Text("CSRF Protection")
                    }
                    .onChange(of: configPrefaData.csrfProtection) { newValue in
                        let prefs = [
                            "web_ui_csrf_protection_enabled": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                    
                    Toggle(isOn: $configPrefaData.hostHeaderValidation) {
                        Text("Host Header Validation")
                    }
                    .onChange(of: configPrefaData.hostHeaderValidation) { newValue in
                        let prefs = [
                            "web_ui_host_header_validation_enabled": newValue
                        ]
                        Task {
                            await configPrefaData.updatePreferences(prefs)
                        }
                    }
                }
            }
        }
        .navigationTitle("Web UI")
        .navigationBarTitleDisplayMode(.inline)
    }
}
