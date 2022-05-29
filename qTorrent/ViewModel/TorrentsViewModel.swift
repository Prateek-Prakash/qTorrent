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
    
    @Published var searchQuery = ""
    
    init() {
        Task {
            let getLogin = await TorrentService.shared.getLogin()
            debugPrint("Login Successful: \(getLogin!)")
            await getTorrentsInfo()
        }
    }
    
    func getTorrentsInfo() async {
        let torrentsInfo = await TorrentService.shared.getTorrentList()
        DispatchQueue.main.async {
            self.torrentList = torrentsInfo
            self.filterList = self.torrentList
        }
    }
    
    func executeSearch() {
        DispatchQueue.main.async {
            self.filterList = self.torrentList?.filter { $0.name.uppercased().contains(self.searchQuery.uppercased()) }
        }
    }
    
    func clearSearch() {
        DispatchQueue.main.async {
            self.filterList = self.torrentList
        }
    }
}
