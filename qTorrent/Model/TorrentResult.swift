//
//  TorrentResult.swift
//  qTorrent
//
//  Created by Prateek Prakash on 6/3/22.
//

import Foundation

struct TorrentResult: Identifiable, Codable {
    var id: UUID = UUID()
    var descLink: String
    var fileName: String
    var fileSize: Int
    var fileUrl: String
    var leechers: Int
    var seeders: Int
    var siteUrl: String

    enum CodingKeys: String, CodingKey {
        case descLink = "descrLink"
        case fileName = "fileName"
        case fileSize = "fileSize"
        case fileUrl = "fileUrl"
        case leechers = "nbLeechers"
        case seeders = "nbSeeders"
        case siteUrl = "siteUrl"
    }
}
