//
//  Piece.swift
//  qTorrent
//
//  Created by Prateek Prakash on 6/3/22.
//

import SwiftUI

struct Piece: Identifiable, Codable {
    var id: UUID = UUID()
    var value: Int

    enum CodingKeys: String, CodingKey {
        case value = "value"
    }
    
    func getStateColor() -> Color {
        switch value {
        case 1:
            return Color(.systemGreen)
        case 2:
            return Color(.systemBlue)
        default:
            return Color(.systemGray)
        }
    }
}
