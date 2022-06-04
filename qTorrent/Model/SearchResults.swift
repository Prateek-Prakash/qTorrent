//
//  SearchResults.swift
//  qTorrent
//
//  Created by Prateek Prakash on 6/3/22.
//

import Foundation

struct SearchResults: Identifiable, Codable {
    var id: UUID = UUID()
    var status: String
    var total: Int
    var results: [TorrentResult]

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case total = "total"
        case results = "results"
    }
}
