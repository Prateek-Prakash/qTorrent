//
//  MainLog.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct MainLog: Identifiable, Codable {
    var id: Int
    var message: String?
    var timestamp: Int?
    var type: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case message = "message"
        case timestamp = "timestamp"
        case type = "type"
    }
    
    func getLogLevel() -> String {
        switch type {
        case 1:
            return "NORMAL"
        case 2:
            return "INFO"
        case 3:
            return "WARNING"
        case 8:
            return "CRITICAL"
        default:
            return "UNKNOWN"
        }
    }
    
    func getLogColor() -> Color? {
        switch type {
        case 1:
            return nil
        case 2:
            return nil
        case 3:
            return Color(.systemYellow)
        case 8:
            return Color(.systemRed)
        default:
            return Color(.systemGray)
        }
    }
}
