//
//  TorrentService.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import Alamofire
import SwiftUI

class TorrentService {
    @AppStorage("remoteUrl") private var remoteUrl = ""
    @AppStorage("remoteUsername") private var remoteUsername = ""
    @AppStorage("remotePassword") private var remotePassword = ""
    
    static let shared = TorrentService()
    
    // Authentication
    
    public func login() async -> Bool? {
        do {
            let params: [String: String] = [
                "username": remoteUsername,
                "password": remotePassword
            ]
            let value = try await AF.upload(multipartFormData: { multiFormData in
                for (key, val) in params {
                    multiFormData.append(Data(val.utf8), withName: key)
                }
            }, to: "\(remoteUrl)/api/v2/auth/login").serializingString().value
            return value == "Ok."
        } catch {
            return nil
        }
    }
    
    public func logout() async -> Bool? {
        do {
            let value = try await AF.request("\(remoteUrl)/api/v2/auth/logout").serializingString(emptyResponseCodes: [200]).value
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
            let value = try await AF.request("\(remoteUrl)/api/v2/torrents/info", parameters: params).serializingDecodable([Torrent]?.self).value
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
            let value = try await AF.request("\(remoteUrl)/api/v2/torrents/pause", parameters: params).serializingString(emptyResponseCodes: [200]).value
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
            let value = try await AF.request("\(remoteUrl)/api/v2/torrents/resume", parameters: params).serializingString(emptyResponseCodes: [200]).value
            return value.isEmpty
        } catch {
            return nil
        }
    }
    
    public func getPieceStates(_ hash: String) async -> [Piece]? {
        do {
            let params: [String: Any] = [
                "hash": hash
            ]
            let values = try await AF.request("\(remoteUrl)/api/v2/torrents/pieceStates", parameters: params).serializingDecodable([Int]?.self).value
            var pieces: [Piece] = []
            for val in values! {
                pieces.append(Piece(id: UUID(), value: val))
            }
            return pieces
        } catch {
            return nil
        }
    }
    
    public func addTorrent(_ url: String) async -> Bool? {
        do {
            let params: [String: String] = [
                "urls": url,
            ]
            let value = try await AF.upload(multipartFormData: { multiFormData in
                for (key, val) in params {
                    multiFormData.append(Data(val.utf8), withName: key)
                }
            }, to: "\(remoteUrl)/api/v2/torrents/add").serializingString().value
            return value == "Ok."
        } catch {
            return nil
        }
    }
    
    public func getContentFiles(_ hash: String) async -> [ContentFile]? {
        do {
            let params: [String: Any] = [
                "hash": hash
            ]
            let values = try await AF.request("\(remoteUrl)/api/v2/torrents/files", parameters: params).serializingDecodable([ContentFile]?.self).value
            return values
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
            let value = try await AF.request("\(remoteUrl)/api/v2/log/main", parameters: params).serializingDecodable([MainLog]?.self).value
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
            let value = try await AF.request("\(remoteUrl)/api/v2/log/peers", parameters: params).serializingDecodable([PeerLog]?.self).value
            return value
        } catch {
            return nil
        }
    }
    
    // Application
    
    public func getPreferences() async -> Preferences? {
        do {
            let value = try await AF.request("\(remoteUrl)/api/v2/app/preferences").serializingDecodable(Preferences?.self).value
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
            let value = try await AF.request("\(remoteUrl)/api/v2/app/setPreferences", parameters: params).serializingString(emptyResponseCodes: [200]).value
            return value.isEmpty
        } catch {
            return nil
        }
    }
    
    // Transfer Info
    
    public func getSpeedLimitsMode() async -> Bool? {
        do {
            let value = try await AF.request("\(remoteUrl)/api/v2/transfer/speedLimitsMode").serializingString().value
            return value == "1"
        } catch {
            return nil
        }
    }
    
    public func toggleSpeedLimitsMode() async -> Bool? {
        do {
            let value = try await AF.request("\(remoteUrl)/api/v2/transfer/toggleSpeedLimitsMode", method: .post).serializingString(emptyResponseCodes: [200]).value
            return value.isEmpty
        } catch {
            return nil
        }
    }
    
    // Search
    
    public func getPlugins() async -> [Plugin]? {
        do {
            let value = try await AF.request("\(remoteUrl)/api/v2/search/plugins").serializingDecodable([Plugin]?.self).value
            return value
        } catch {
            return nil
        }
    }
    
    public func togglePlugins(_ names: [String], _ enable: Bool) async -> Bool? {
        do {
            let params: [String: Any] = [
                "names": names.joined(separator: "|"),
                "enable": String(enable)
            ]
            let value = try await AF.request("\(remoteUrl)/api/v2/search/enablePlugin", parameters: params).serializingString(emptyResponseCodes: [200]).value
            return value.isEmpty
        } catch {
            return nil
        }
    }
    
    public func startSearch(_ pattern: String) async -> StartSearch? {
        do {
            let params: [String: Any] = [
                "pattern": pattern,
                "plugins": "all",
                "category": "all"
            ]
            let value = try await AF.request("\(remoteUrl)/api/v2/search/start", parameters: params).serializingDecodable(StartSearch?.self).value
            return value
        } catch {
            return nil
        }
    }
    
    public func stopSearch(_ id: Int) async -> Bool? {
        do {
            let params: [String: Any] = [
                "id": id
            ]
            let value = try await AF.request("\(remoteUrl)/api/v2/search/stop", parameters: params).serializingString(emptyResponseCodes: [200]).value
            return value.isEmpty
        } catch {
            return nil
        }
    }
    
    public func deleteSearch(_ id: Int) async -> Bool? {
        do {
            let params: [String: Any] = [
                "id": id
            ]
            let value = try await AF.request("\(remoteUrl)/api/v2/search/delete", parameters: params).serializingString(emptyResponseCodes: [200]).value
            return value.isEmpty
        } catch {
            return nil
        }
    }
    
    public func getSearchResults(_ id: Int) async -> SearchResults? {
        do {
            let params: [String: Any] = [
                "id": id
            ]
            let value = try await AF.request("\(remoteUrl)/api/v2/search/results", parameters: params).serializingDecodable(SearchResults?.self).value
            return value
        } catch {
            return nil
        }
    }
}
