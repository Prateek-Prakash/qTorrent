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
                    
                    Toggle(isOn: $csrfProtection) {
                        Text("CSRF Protection")
                    }
                    
                    Toggle(isOn: $hostHeaderValidation) {
                        Text("Host Header Validation")
                    }
                }
            }
        }
        .navigationTitle("Web UI")
        .navigationBarTitleDisplayMode(.inline)
    }
}
