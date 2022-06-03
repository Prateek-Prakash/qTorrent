//
//  PluginsPrefsView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 6/3/22.
//

import SwiftUI

struct PluginsPrefsView: View {
    @State var completeList: [Plugin] = []
    
    var body: some View {
        VStack {
            List {
                ForEach(completeList.indices, id: \.self) { pluginIndex in
                    Toggle(isOn: $completeList[pluginIndex].enabled) {
                        Text(completeList[pluginIndex].fullName)
                    }
                    .onChange(of: completeList[pluginIndex].enabled) { newBool in
                        Task {
                            await TorrentService.shared.togglePlugins([completeList[pluginIndex].name], newBool)
                            await fetchPlugins()
                        }
                    }
                }
            }
        }
        .navigationTitle("Search Plugins")
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
