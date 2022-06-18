//
//  SearchEnginePrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 6/3/22.
//

import SwiftUI

struct SearchEnginePrefsView: View {
    @State var completeList: [Plugin] = []
    
    var body: some View {
        VStack {
            List {
                ForEach(completeList.indices, id: \.self) { pluginIndex in
                    Toggle(isOn: $completeList[pluginIndex].enabled) {
                        Text(completeList[pluginIndex].fullName)
                    }
                    .onChange(of: completeList[pluginIndex].enabled) { newValue in
                        Task {
                            await TorrentService.shared.togglePlugins([completeList[pluginIndex].name], newValue)
                            await fetchPlugins()
                        }
                    }
                }
            }
        }
        .navigationTitle("Search Engine")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await fetchPlugins()
            }
        }
    }
    
    // Functions
    
    func fetchPlugins() async {
        if let plugins = await TorrentService.shared.getPlugins() {
            completeList = plugins
        }
    }
}
