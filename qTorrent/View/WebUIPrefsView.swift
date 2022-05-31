//
//  WebUIPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct WebUIPrefsView: View {
    @State var clickjackingProtection = true
    @State var csrfProtection = true
    @State var hostHeaderValidation = true
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("SECURITY")) {
                    Toggle(isOn: $clickjackingProtection) {
                        Text("Clickjacking Protection")
                    }
                    .onChange(of: clickjackingProtection) { newBool in
                        let prefs = [
                            "web_ui_clickjacking_protection_enabled": newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                            await fetchPreferences()
                        }
                    }
                    
                    Toggle(isOn: $csrfProtection) {
                        Text("CSRF Protection")
                    }
                    .onChange(of: csrfProtection) { newBool in
                        let prefs = [
                            "web_ui_csrf_protection_enabled": newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                            await fetchPreferences()
                        }
                    }
                    
                    Toggle(isOn: $hostHeaderValidation) {
                        Text("Host Header Validation")
                    }
                    .onChange(of: hostHeaderValidation) { newBool in
                        let prefs = [
                            "web_ui_host_header_validation_enabled": newBool
                        ]
                        let json = try? JSONSerialization.data(withJSONObject: prefs)
                        let string = String(data: json!, encoding: String.Encoding.ascii)
                        Task {
                            await TorrentService.shared.setPreferences(string!)
                            await fetchPreferences()
                        }
                    }
                }
            }
        }
        .navigationTitle("Web UI")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await fetchPreferences()
            }
        }
    }
    
    // Functions
    
    func fetchPreferences() async {
        let preferences = await TorrentService.shared.getPreferences()
        clickjackingProtection = preferences!.isWebUIClickjackingProtectionEnabled
        csrfProtection = preferences!.isWebUICSRFProtectionEnabled
        hostHeaderValidation = preferences!.isWebUIHostHeaderValidationEnabled
    }
}
