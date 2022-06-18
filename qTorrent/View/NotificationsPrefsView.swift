//
//  NotificationsPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 6/17/22.
//

import SwiftUI

struct NotificationsPrefsView: View {
    @AppStorage("notifierUrl") private var notifierUrl = ""
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("NOTIFIER API")) {
                    TextField("API Base URL", text: $notifierUrl)
                        .modifier(TextFieldClearModifier(text: $notifierUrl))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
            }
        }
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
    }
}
