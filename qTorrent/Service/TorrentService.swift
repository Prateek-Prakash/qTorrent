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
    
    public func login() async -> Bool? {
        do {
            let params: [String: Any] = [
                "username": remoteUsername,
                "password": remotePassword
            ]
            let value = try await AF.request("\(baseUrl)/api/v2/auth/login", parameters: params).serializingString().value
            return value == "Ok."
        } catch {
            return nil
        }
    }
    
    public func logout() async -> Bool? {
        do {
            let value = try await AF.request("\(baseUrl)/api/v2/auth/logout").serializingString().value
            return value.isEmpty
        } catch {
            return nil
        }
    }
    
    // Torrents
    
    public func getTorrents() async -> [Torrent]? {
        do {
            let params: [String: Any] = [
                "filter": "all"
            ]
            let value = try await AF.request("\(baseUrl)/api/v2/torrents/info", parameters: params).serializingDecodable([Torrent]?.self).value
            return value
        } catch {
            return nil
        }
    }
    
    public func pause(_ hashes: [String]) async -> Bool? {
        do {
            let params: [String: Any] = [
                "hashes": hashes.joined(separator: "|")
            ]
            let value = try await AF.request("\(baseUrl)/api/v2/torrents/pause", parameters: params).serializingString().value
            return value.isEmpty
        } catch {
            return nil
        }
    }
    
    public func resume(_ hashes: [String]) async -> Bool? {
        do {
            let params: [String: Any] = [
                "hashes": hashes.joined(separator: "|")
            ]
            let value = try await AF.request("\(baseUrl)/api/v2/torrents/resume", parameters: params).serializingString().value
            return value.isEmpty
        } catch {
            return nil
        }
    }
    
    // Logs
    
    public func getMainLogs() async -> [MainLog]? {
        do {
            let params: [String: Any] = [
                "normal": true,
                "info": true,
                "warning": true,
                "critical": true,
                "last_known_id": -1
            ]
            let value = try await AF.request("\(baseUrl)/api/v2/log/main", parameters: params).serializingDecodable([MainLog]?.self).value
            return value
        } catch {
            return nil
        }
    }
    
    public func getPeerLogs() async -> [PeerLog]? {
        do {
            let params: [String: Any] = [
                "last_known_id": -1
            ]
            let value = try await AF.request("\(baseUrl)/api/v2/log/peers", parameters: params).serializingDecodable([PeerLog]?.self).value
            return value
        } catch {
            return nil
        }
    }
    
    // Application
    
    public func getPreferences() async -> Preferences? {
        do {
            let value = try await AF.request("\(baseUrl)/api/v2/app/preferences").serializingDecodable(Preferences?.self).value
            return value
        } catch {
            return nil
        }
    }
    
    public func setPreferences(_ json: String) async -> Bool? {
        do {
            let params: [String: Any] = [
                "json": json
            ]
            let value = try await AF.request("\(baseUrl)/api/v2/app/setPreferences", parameters: params).serializingString().value
            return value.isEmpty
        } catch {
            return nil
        }
    }
}
