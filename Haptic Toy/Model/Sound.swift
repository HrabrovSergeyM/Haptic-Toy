//
//  Sound.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.08.2023.
//

import Foundation

struct Sound {
    let name: String
    let tracks: [String]
}

enum SoundType {
    case breakingBass
    case feverNights
    case acousticGuitar
    case studioBass
}

extension SoundType {
    var name: String {
        switch self {
            case .breakingBass: return "Breaking Bass"
            case .feverNights: return "Fever Nights"
            case .acousticGuitar: return "Acoustic Guitar"
            case .studioBass: return "Studio Bass"
        }
    }
    
    var tracks: [String] {
        switch self {
            case .breakingBass: return ["breakingBass0", "breakingBass1", "breakingBass2", "breakingBass3", "breakingBass4", "breakingBass5", "breakingBass6", "breakingBass7", "breakingBass8", "breakingBass9", "breakingBass10", "breakingBass11", "breakingBass12", "breakingBass13", "breakingBass14"]
            case .feverNights: return ["feverNights0", "feverNights1", "feverNights2", "feverNights3", "feverNights4", "feverNights5", "feverNights6", "feverNights7", "feverNights8", "feverNights9", "feverNights10", "feverNights11", "feverNights12", "feverNights13", "feverNights14"]
            case .acousticGuitar: return ["acousticGuitar0", "acousticGuitar1", "acousticGuitar2", "acousticGuitar3", "acousticGuitar4", "acousticGuitar5", "acousticGuitar6", "acousticGuitar7", "acousticGuitar8", "acousticGuitar9", "acousticGuitar10", "acousticGuitar11", "acousticGuitar12", "acousticGuitar13", "acousticGuitar14"]
            case .studioBass: return ["studioBass0", "studioBass1", "studioBass2", "studioBass3", "studioBass4", "studioBass5", "studioBass6", "studioBass7", "studioBass8", "studioBass9", "studioBass10", "studioBass11", "studioBass12", "studioBass13", "studioBass14"]
        }
    }
}
