//
//  TorrentsViewModel.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

class TorrentsViewModel: ObservableObject {
    @Published var torrentList: [TorrentInfo]? = []
    @Published var filterList: [TorrentInfo]? = []
    
    func getTorrentsInfo() async {
        let torrentsInfo = await TorrentService.shared.getTorrentList()
        DispatchQueue.main.async {
            self.torrentList = torrentsInfo
            self.filterList = self.torrentList
        }
    }
    
    func executeSearch(_ searchQuery: String) {
        DispatchQueue.main.async {
            self.filterList = self.torrentList?.filter { $0.name.uppercased().contains(searchQuery.uppercased()) }
        }
    }
    
    func clearSearch() {
        DispatchQueue.main.async {
            self.filterList = self.torrentList
        }
    }
}
