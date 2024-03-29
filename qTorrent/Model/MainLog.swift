//
//  MainLog.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct MainLog: Identifiable, Codable {
    var id: Int
    var message: String
    var timestamp: Int
    var type: Int
    
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
        case 4:
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
            return Color(.systemBlue)
        case 4:
            return Color(.systemYellow)
        case 8:
            return Color(.systemRed)
        default:
            return Color(.systemGray)
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
