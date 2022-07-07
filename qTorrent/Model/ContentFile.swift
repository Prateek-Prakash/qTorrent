//
//  ContentFile.swift
//  qTorrent
//
//  Created by Prateek Prakash on 7/6/22.
//

import Foundation

struct ContentFile: Identifiable, Codable {
    var id: Int { index }
    var index: Int
    var name: String
    var size: Int
    var progress: Float
    var priority: Int
    var isSeed: Bool?
    var pieceRange: [Int]
    var availability: Float
    
    
    enum CodingKeys: String, CodingKey {
        case index = "index"
        case name = "name"
        case size = "size"
        case progress = "progress"
        case priority = "priority"
        case isSeed = "is_ssed"
        case pieceRange = "piece_range"
        case availability = "availability"
    }
}
