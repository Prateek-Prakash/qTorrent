//
//  AuthPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

struct AuthPrefsView: View {
    @AppStorage("remoteUrl") private var remoteUrl = ""
    @AppStorage("remoteUsername") private var remoteUsername = ""
    @AppStorage("remotePassword") private var remotePassword = ""
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("REMOTE API")) {
                    TextField("API Base URL", text: $remoteUrl)
                        .modifier(TextFieldClearModifier(text: $remoteUrl))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
                Section(header: Text("REMOTE CREDENTIALS")) {
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
