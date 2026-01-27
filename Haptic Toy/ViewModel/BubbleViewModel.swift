//
//  BubbleViewModel.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 15.08.2023.
//

import Foundation

enum BubbleAsset {
    static let prepopped: [String] = [
        "softPrepopped",
        "softPrepopped2",
        "softPrepopped3",
        "softPrepopped4"
    ]
    
    static let popped: [String] = [
        "softPopped",
        "softPopped2",
        "softPopped3",
        "softPopped4",
        "softPopped5"
    ]
    
    static func randomPrepopped() -> String {
        prepopped.randomElement() ?? prepopped.first ?? "softPrepopped"
    }
    
    static func randomPopped() -> String {
        popped.randomElement() ?? popped.first ?? "softPopped"
    }
}

enum SoundName {
    static let popSound2 = "popSound2"
}
