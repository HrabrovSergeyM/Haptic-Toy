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

enum Language: String {
    case russian = "ru"
    case english_us = "en"
}

enum SceneUpdate {
    case resetBubbles
    case updateBubbles
    case noChange
}

let themeData: [ColorTheme] = [
    ColorTheme(id: 0, themeName: "Default", themeAccentColor: .primary, themePrimaryColor: Color(.systemGray6), themeSecondaryColor: Color(UIColor.tertiarySystemBackground), themeForegroundColor: .primary, themePreview: "lightDefaultPreview", bubbleNavigationImage: ""),
    
    ColorTheme(id: 1, themeName: "Blue", themeAccentColor: Color("AccentBlueColor"), themePrimaryColor: Color("PrimaryBlueColor"), themeSecondaryColor: Color("SecondaryBlueColor"), themeForegroundColor: .white, themePreview: "lightBluePreview", bubbleNavigationImage: ""),
    
    ColorTheme(id: 2, themeName: "Pink", themeAccentColor: Color("AccentPinkColor"), themePrimaryColor: Color("PrimaryPinkColor"), themeSecondaryColor: Color("SecondaryPinkColor"), themeForegroundColor: .white, themePreview: "lightPinkPreview", bubbleNavigationImage: ""),
    
    ColorTheme(id: 3, themeName: "Green", themeAccentColor: Color("AccentGreenColor"), themePrimaryColor: Color("PrimaryGreenColor"), themeSecondaryColor: Color("SecondaryGreenColor"), themeForegroundColor: .white, themePreview: "lightGreenPreview", bubbleNavigationImage: "")
]
