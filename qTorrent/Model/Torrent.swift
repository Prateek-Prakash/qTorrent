//
//  Torrent.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

struct Torrent: Identifiable, Codable {
    var id: String { hash }
    var addedOn: Int?
    var bytesLeft: Int?
    var isManagedByATM: Bool?
    var availability: Float?
    var category: String?
    var bytesCompleted: Int?
    var completionOn: Int?
    var contentPath: String?
    var dlLimit: Int?
    var dlSpeed: Int?
    var downloaded: Int?
    var downloadedSession: Int?
    var etaSeconds: Int?
    var isFirstLastPrioritized: Bool?
    var isForceStart: Bool?
    var hash: String
    var lastActivity: Int?
    var magnetUri: String?
    var maxRatio: Int?
    var maxSeedingTime: Int?
    var name: String
    var numComplete: Int?
    var numIncomplete: Int?
    var numLeechs : Int?
    var numSeeds: Int?
    var priority: Int?
    var progress: Float?
    var ratio: Float?
    var ratioLimit: Float?
    var savePath: String?
    var seedingTime: Int?
    var seedingTimeLimit: Int?
    var seenSomplete: Int?
    var isSequentialDownload: Bool?
    var selectedBytes: Int?
    var state: String
    var isSuperSeeding: Bool?
    var tags: String?
    var timeActive: Int?
    var totalBytes: Int?
    var tracker: String?
    var upLimit: Int?
    var uploaded: Int?
    var uploadedSession: Int?
    var upSpeed: Int?
    
    enum CodingKeys: String, CodingKey {
        case addedOn = "added_on"
        case bytesLeft = "amount_left"
        case isManagedByATM = "auto_tmm"
        case availability = "availability"
        case category = "category"
        case bytesCompleted = "completed"
        case completionOn = "completion_on"
        case contentPath = "content_path"
        case dlLimit = "dl_limit"
        case dlSpeed = "dlspeed"
        case downloaded = "downloaded"
        case downloadedSession = "downloaded_session"
        case etaSeconds = "eta"
        case isFirstLastPrioritized = "f_l_piece_prio"
        case isForceStart = "force_start"
        case hash = "hash"
        case lastActivity = "last_activity"
        case magnetUri = "magnet_uri"
        case maxRatio = "max_ratio"
        case maxSeedingTime = "max_seeding_time"
        case name = "name"
        case numComplete = "num_complete"
        case numIncomplete = "num_incomplete"
        case numLeechs = "num_leechs    "
        case numSeeds = "num_seeds"
        case priority = "priority"
        case progress = "progress"
        case ratio = "ratio"
        case ratioLimit = "ratio_limit"
        case savePath = "save_path"
        case seedingTime = "seeding_time"
        case seedingTimeLimit = "seeding_time_limit "
        case seenSomplete = "seen_complete"
        case isSequentialDownload = "seq_dl"
        case selectedBytes = "size"
        case state = "state"
        case isSuperSeeding = "super_seeding"
        case tags = "tags"
        case timeActive = "time_active"
        case totalBytes = "total_size"
        case tracker = "tracker"
        case upLimit = "up_limit"
        case uploaded = "uploaded"
        case uploadedSession = "uploaded_session"
        case upSpeed = "upspeed"
    }
    
    func getStateIcon() -> String {
        switch self.state {
        case "uploading", "forcedUP":
            return "arrow.up.circle"
        case "queuedUP", "stalledUP", "checkingUP":
            return "arrow.up.circle"
        case "queuedDL", "stalledDL", "checkingDL":
            return "arrow.down.circle"
        case "metaDL", "allocating", "downloading", "forcedDL":
            return "arrow.down.circle"
        case "pausedUP", "pausedDL":
            return "arrow.up.circle"
        case "error", "missingFiles":
            return "exclamationmark.circle"
        case "unknown", "checkingResumeData", "moving":
            return "questionmark.circle"
        default:
            return "questionmark.circle"
        }
    }
    
    func getStateColor() -> Color? {
        switch self.state {
        case "uploading", "forcedUP":
            return Color(.systemGreen)
        case "queuedUP", "stalledUP", "checkingUP":
            return Color(.systemYellow)
        case "queuedDL", "stalledDL", "checkingDL":
            return Color(.systemYellow)
        case "metaDL", "allocating", "downloading", "forcedDL":
            return Color(.systemGreen)
        case "pausedUP", "pausedDL":
            return Color(.systemBlue)
        case "error", "missingFiles":
            return Color(.systemRed)
        case "unknown", "checkingResumeData", "moving":
            return nil
        default:
            return nil
        }
    }
}
