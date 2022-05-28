//
//  AuthPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

struct AuthPrefsView: View {
    @AppStorage("baseUrl") var baseUrl = ""
    @AppStorage("remoteUsername") var remoteUsername = ""
    @AppStorage("remotePassword") var remotePassword = ""
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Remote API")) {
                    TextField("Base URL", text: $baseUrl)
                        .modifier(TextFieldClearModifier(text: $baseUrl))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
                Section(header: Text("Remote Credentials")) {
                    TextField("Username", text: $remoteUsername)
                        .modifier(TextFieldClearModifier(text: $remoteUsername))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    SecureField("Password", text: $remotePassword)
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
