//
//  TorrentService.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import Alamofire
import SwiftUI

class TorrentService {
    @AppStorage("baseUrl") private var baseUrl = ""
    @AppStorage("remoteUsername") private var remoteUsername = ""
    @AppStorage("remotePassword") private var remotePassword = ""
    
    static let shared = TorrentService()
    
    // Authentication
    
    public func getLogin() async -> Bool? {
        do {
            let params = [
                "username": remoteUsername,
                "password": remotePassword
            ]
            let value = try await AF.request("\(baseUrl)/api/v2/auth/login", parameters: params).serializingString().value
            return value == "Ok."
        } catch {
            return nil
        }
    }
    
    public func getLogout() async -> Bool? {
        do {
            let value = try await AF.request("\(baseUrl)/api/v2/auth/logout").serializingString().value
            return value.isEmpty
        } catch {
            return nil
        }
    }
    
    // Torrents
    
    public func getTorrentList() async throws -> [Torrent]? {
        do {
            let params = [
                "filter": "all"
            ]
            let value = try await AF.request("\(baseUrl)/api/v2/torrents/info", parameters: params).serializingDecodable([Torrent]?.self).value
            return value
        } catch {
            return nil
        }
    }
}
