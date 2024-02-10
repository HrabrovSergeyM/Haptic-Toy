//
//  ColorThemeChangerService.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 01.09.2023.
//

import SwiftUI

final public class ColorThemeChangerService: ObservableObject {
    private static let themeKey = "Theme"
    @Published public var themeSettings: Int = UserDefaults.standard.integer(forKey: themeKey) {
        didSet {
            UserDefaults.standard.set(self.themeSettings, forKey: ColorThemeChangerService.themeKey)
        }
    }
    private init() {}
    public static let shared = ColorThemeChangerService()
}
