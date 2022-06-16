//
//  BitTorrentProtocol.swift
//  qTorrent
//
//  Created by Prateek Prakash on 6/16/22.
//

import BetterListPicker
import Foundation

enum BitTorrentProtocol: String, CaseIterable {
    case both = "TCP & μTP"
    case tcp = "TCP"
    case utp = "μTP"
    
    var indexValue: Int {
        switch self {
        case .both:
            return 0
        case .tcp:
            return 1
        case .utp:
            return 2
        }
    }
    
    static func fromIndex(_ index: Int) -> Optional<BitTorrentProtocol> {
        switch index {
        case 0:
            return .both
        case 1:
            return .tcp
        case 2:
            return .utp
        default:
            return .none
        }
    }
}

extension BitTorrentProtocol: BetterListPickerSelectable, Identifiable {
    var id: Int { indexValue }
    var title: String { rawValue }
}
