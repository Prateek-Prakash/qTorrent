//
//  AuthPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

struct AuthPrefsView: View {
    @AppStorage("baseUrl") private var baseUrl = ""
    @AppStorage("remoteUsername") private var remoteUsername = ""
    @AppStorage("remotePassword") private var remotePassword = ""
    
    var connectionStatus = "INVALID"
    var connectionColor = Color(.systemRed)
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Remote API")) {
                    TextField("API Base URL", text: $baseUrl)
                        .modifier(TextFieldClearModifier(text: $baseUrl))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
                Section(header: Text("Remote Credentials")) {
                    TextField("Remmote Username", text: $remoteUsername)
                        .modifier(TextFieldClearModifier(text: $remoteUsername))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    SecureField("Remote Password", text: $remotePassword)
                        .modifier(TextFieldClearModifier(text: $remotePassword))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
            }
        }
        .navigationTitle("Authentication")
        .navigationBarTitleDisplayMode(.inline)
    }
}
