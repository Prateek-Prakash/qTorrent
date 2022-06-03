//
//  Plugin.swift
//  qTorrent
//
//  Created by Prateek Prakash on 6/3/22.
//

struct Plugin: Identifiable, Codable {
    var id: String { name }
    var enabled: Bool
    var fullName: String
    var name: String
    // supportedCategories
    var url: String
    var version: String
    
    enum CodingKeys: String, CodingKey {
        case enabled = "enabled"
        case fullName = "fullName"
        case name = "name"
        // supportedCategories
        case url = "url"
        case version = "version"
    }
}
