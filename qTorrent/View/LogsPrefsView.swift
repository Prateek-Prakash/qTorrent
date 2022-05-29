//
//  LogsPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct LogsPrefsView: View {
    @State var displayNormal = true
    @State var displayInfo = true
    @State var displayWarning = true
    @State var displayCritical = true
    
    var body: some View {
        VStack {
            List {
                
            }
        }
        .navigationTitle("Logs")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Menu {
                Button {
                    displayNormal.toggle()
                } label: {
                    Text("Normal").tag(1)
                    if displayNormal {
                        Image(systemName: "checkmark")
                    }
                }
                
                Button {
                    displayInfo.toggle()
                } label: {
                    Text("Info").tag(2)
                    if displayInfo {
                        Image(systemName: "checkmark")
                    }
                }
                
                Button {
                    displayWarning.toggle()
                } label: {
                    Text("Warning").tag(3)
                    if displayWarning {
                        Image(systemName: "checkmark")
                    }
                }
                
                Button {
                    displayCritical.toggle()
                } label: {
                    Text("Critical").tag(8)
                    if displayCritical {
                        Image(systemName: "checkmark")
                    }
                }
            } label: {
                Label("Filter", systemImage: "slider.horizontal.3")
            }
        }
    }
}
