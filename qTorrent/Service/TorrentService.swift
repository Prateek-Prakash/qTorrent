//
//  TorrentService.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

class TorrentService {
    @AppStorage("baseUrl") private var baseUrl = ""
    @AppStorage("remoteUsername") private var remoteUsername = ""
    @AppStorage("remotePassword") private var remotePassword = ""
    
    static let shared = TorrentService()
    
    // Authentication
    
    public func login() async throws -> Bool {
        return true
    }
}
