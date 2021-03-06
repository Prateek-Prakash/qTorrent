//
//  NotificationsPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 6/17/22.
//

import SwiftUI

struct NotificationsPrefsView: View {
    @AppStorage("allowNotifications") private var allowNotifications = true
    @AppStorage("notifierUrl") private var notifierUrl = ""
    
    var body: some View {
        VStack {
            List {
                Toggle(isOn: $allowNotifications) {
                    Text("Allow Notifications")
                }
                .onChange(of: allowNotifications) { newValue in
                    Task {
                        if newValue {
                            await NotifierService.shared.registerToken()
                        } else {
                            await NotifierService.shared.deregisterToken()
                        }
                    }
                }
                
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
