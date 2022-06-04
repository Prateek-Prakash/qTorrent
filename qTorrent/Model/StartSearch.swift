//
//  StartSearch.swift
//  qTorrent
//
//  Created by Prateek Prakash on 6/3/22.
//

struct StartSearch: Identifiable, Codable {
    var id: Int

    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
