//
//  AppTheme.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import BetterListPicker
import SwiftUI

enum AppTheme: String, CaseIterable {
    case system = "System"
    case dark = "Dark"
    case light = "Light"
    
    var colorScheme: Optional<ColorScheme> {
        switch self {
        case .system:
            return .none
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

extension AppTheme: BetterListPickerSelectable, Identifiable {
    var id: String { rawValue }
    var title: String { rawValue }
}
