//
//  PeerLog.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/30/22.
//

import SwiftUI

struct PeerLog: Identifiable, Codable {
    var id: Int
    var ip: String
    var timestamp: Int
    var blocked: Bool
    var reason: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case ip = "ip"
        case timestamp = "timestamp"
        case blocked = "blocked"
        case reason = "reason"
    }
    
    func getLogColor() -> Color? {
        switch blocked {
        case true:
            return Color(.systemRed)
        case false:
            return Color(.systemGreen)
        }
    }
    
    func getDate() -> String {
        let epochTime = TimeInterval(timestamp) / 1000
        let currDate = Date(timeIntervalSince1970: epochTime)
        let dateFormet = DateFormatter()
        dateFormet.dateFormat = "MM-dd-YYYY @ hh:mm:ss.SSS a"
        return dateFormet.string(from: currDate)
    }
}
