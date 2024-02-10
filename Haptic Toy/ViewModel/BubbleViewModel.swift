//
//  BubbleViewModel.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 15.08.2023.
//

import Foundation

class BubbleViewModel: ObservableObject {
    let audioManager = AudioManager()
    @Published var isPopped: Bool = false
    @Published var soundEffects: [String] = [SoundName.popBubble1, SoundName.popBubble2]
    @Published var prepopped: [String] = [SoundName.softPrepopped, SoundName.softPrepopped2, SoundName.softPrepopped3, SoundName.softPrepopped4]
    @Published var popped: [String] = [SoundName.softPopped, SoundName.softPopped2, SoundName.softPopped3, SoundName.softPopped4, SoundName.softPopped5]
    
    func popBubble() {
        if !isPopped {
            isPopped = true
            audioManager.startSound(sound: SoundName.popSound2, type: "mp3")
            HapticManager.impact(style: .rigid)
        }
    }
}

enum SoundName {
    static let popSound2 = "popSound2"
    static let popBubble1 = "popBubble1"
    static let popBubble2 = "popBubble2"
    static let softPrepopped = "softPrepopped"
    static let softPrepopped2 = "softPrepopped2"
    static let softPrepopped3 = "softPrepopped3"
    static let softPrepopped4 = "softPrepopped4"
    static let softPopped = "softPopped"
    static let softPopped2 = "softPopped2"
    static let softPopped3 = "softPopped3"
    static let softPopped4 = "softPopped4"
    static let softPopped5 = "softPopped5"
}
