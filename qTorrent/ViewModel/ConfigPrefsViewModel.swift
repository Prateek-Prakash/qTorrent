//
//  ConfigPrefsViewModel.swift
//  qTorrent
//
//  Created by Prateek Prakash on 6/16/22.
//

import Combine
import SwiftUI

class ConfigPrefsViewModel: ObservableObject {
    // Downloads
    @Published var preallocateDiskSpace = false
    @Published var appendIncompleteExtension = true
    @Published var autoStartTorrent = true
    @Published var deleteTorrentAfter = true
    @Published var runExternalProgram = false
    
    // Connection
    @Published var bitTorrentProtocol: BitTorrentProtocol = .both
    
    // Speed
    @Published var limitUTP = true
    @Published var limitTCPOverhead = false
    @Published var limitLANPeers = true
    
    // BitTorrent
    @Published var enableDHT = true
    @Published var enablePeX = true
    @Published var enableLSD = true
    @Published var anonymousMode = false
    
    // RSS
    @Published var fetchRSSFeeds = false
    @Published var autoDownloadRSSTorrents = false
    @Published var downloadRepackProperEpisodes = true
    
    // WebUI
    @Published var clickjackingProtection = true
    @Published var csrfProtection = true
    @Published var hostHeaderValidation = true
    
    // Advanced
    @Published var recheckCompletedTorrents = false
    @Published var resolvePeerCountrie = true
    @Published var reannounceWhenAddressChanges = false
    @Published var embeddedTracker = false
    @Published var enableOSCache = true
    @Published var coalesceReadsWrites = true
    @Published var usePieceExtentAffinity = false
    @Published var sendUploadPieceSuggestions = false
    
    init() {
        Task {
            await fetchPreferences()
        }
    }
    
    func fetchPreferences() async {
        let preferences = await TorrentService.shared.getPreferences()!
        DispatchQueue.main.async {
            // Downloads
            self.preallocateDiskSpace = preferences.isPreallocateAll
            self.appendIncompleteExtension = preferences.isIncompleteFilesExt
            self.autoStartTorrent = !preferences.isStartPausedEnabled
            self.deleteTorrentAfter = preferences.autoDeleteMode == 1 ? true : false
            
            // Connection
            self.bitTorrentProtocol = BitTorrentProtocol.fromIndex(preferences.bitTorrentProtocol)!
            
            // Speed
            self.limitUTP = preferences.isLimitUTPRate
            self.limitTCPOverhead = preferences.isLimitTCPOverhead
            self.limitLANPeers = preferences.isLimitLANPeers
            
            // BitTorrent
            self.enableDHT = preferences.isDHT
            self.enablePeX = preferences.isPeX
            self.enableLSD = preferences.isLSD
            self.anonymousMode = preferences.isAnonymousMode
            
            // RSS
            self.fetchRSSFeeds = preferences.isRSSProcessingEnabled
            self.autoDownloadRSSTorrents = preferences.isRSSAutoDownloadingEnabled
            self.downloadRepackProperEpisodes = preferences.isRSSDownloadRepackProperEpisodes
            
            // WebUI
            self.clickjackingProtection = preferences.isWebUIClickjackingProtectionEnabled
            self.csrfProtection = preferences.isWebUICSRFProtectionEnabled
            self.hostHeaderValidation = preferences.isWebUIHostHeaderValidationEnabled
            
            // Advanced
            self.recheckCompletedTorrents = preferences.isRecheckCompletedTorrents
            self.resolvePeerCountrie = preferences.isResolvePeerCountries
            self.reannounceWhenAddressChanges = preferences.isReannounceWhenAddressChanged
            self.embeddedTracker = preferences.isEnableEmbeddedTracker
            self.coalesceReadsWrites = preferences.isEnableCoalesceReadWrite
            self.usePieceExtentAffinity = preferences.isEnablePieceExtentAffinity
            self.sendUploadPieceSuggestions = preferences.isEnableUploadSuggestions
        }
    }
    
    func updatePreferences(_ prefs: [String: Any]) async {
        let json = try? JSONSerialization.data(withJSONObject: prefs)
        let string = String(data: json!, encoding: String.Encoding.ascii)
        Task {
            await TorrentService.shared.setPreferences(string!)
            await fetchPreferences()
        }
    }
}
