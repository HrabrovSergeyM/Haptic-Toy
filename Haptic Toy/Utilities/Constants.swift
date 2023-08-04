//
//  Constants.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 29.07.2023.
//

import Foundation
import SwiftUI

enum HapticStyle: String, CaseIterable {
    case soft, light, medium, rigid, heavy

    var feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle {
        switch self {
        case .soft:
            return .soft
        case .light:
            return .light
        case .medium:
            return .medium
        case .rigid:
            return .rigid
        case .heavy:
            return .heavy
        }
    }

    var titleWeight: Font.Weight {
        switch self {
        case .soft:
            return .thin
        case .light:
            return .light
        case .medium:
            return .medium
        case .rigid:
            return .semibold
        case .heavy:
            return .heavy
        }
    }
}

enum DisplayMode: String {
    case standard, extended, maximum
    
    mutating func toggle() {
            switch self {
            case .standard:
                self = .extended
            case .extended:
                self = .maximum
            case .maximum:
                self = .standard
            }
        }
}
