//
//  ColorThemeModel.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 01.09.2023.
//

import SwiftUI

struct ColorTheme: Identifiable {
    let id: Int
    let themeName: String
    let themeAccentColor: Color
    let themePrimaryColor: Color
    let themeSecondaryColor: Color
    let themeForegroundColor: Color
    let themePreview: String
    let bubbleNavigationImage: String
}
