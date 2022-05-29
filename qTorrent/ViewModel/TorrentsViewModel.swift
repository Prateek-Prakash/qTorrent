//
//  TorrentsViewModel.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

class TorrentsViewModel: ObservableObject {
    @Published var torrentList: [TorrentInfo]? = []
    
    init() {
        Task {
            let getLogin = await TorrentService.shared.getLogin()
            debugPrint("Login Successful: \(getLogin!)")
            await getTorrentsInfo()
        }
    }
    
    func getTorrentsInfo() async {
        let torrentList = await TorrentService.shared.getTorrentList()
        DispatchQueue.main.async {
            self.torrentList = torrentList
        }
    }
}
