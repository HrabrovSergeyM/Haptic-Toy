//
//  LocalizationService.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 06.08.2023.
//

import Foundation

class LocalizationService {
    
    static let shared = LocalizationService()
    static let changedLanguage = Notification.Name("changedLanguage")
    
    private init() {
        checkForLanguageChange()
    }
    
    private func checkForLanguageChange() {
        let currentAppLanguage = UserDefaults.standard.string(forKey: "language")
        let systemLanguage = Bundle.main.preferredLocalizations.first
        
        if let systemLanguage = systemLanguage, systemLanguage != currentAppLanguage {
            self.language = Language(rawValue: systemLanguage) ?? .english_us
        }
    }
    
    var language: Language {
        get {
            guard let languageString = UserDefaults.standard.string(forKey: "language") else {
                return .english_us
            }
            return Language(rawValue: languageString) ?? .english_us
        } set {
            if newValue != language {
                UserDefaults.standard.setValue(newValue.rawValue, forKey: "language")
                NotificationCenter.default.post(name: LocalizationService.changedLanguage, object: nil)
            }
        }
    }
    
}
