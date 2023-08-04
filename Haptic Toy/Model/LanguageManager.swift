//
//  LanguageManager.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 04.08.2023.
//

import Foundation
import SwiftUI

struct LanguageManager {
    @AppStorage("Language") static var language = Locale.current.language.languageCode?.identifier ?? "en"
    
    static func localized(_ key: String) -> String {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(key, bundle: bundle!, comment: "")
    }
}

