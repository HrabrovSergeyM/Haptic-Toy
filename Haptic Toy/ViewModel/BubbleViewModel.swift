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
    @Published var soundEffects: [String] = ["popBubble1", "popBubble2"]
    @Published var prepopped: [String] = ["softPrepopped", "softPrepopped2", "softPrepopped3", "softPrepopped4"]
    @Published var popped: [String] = ["softPopped", "softPopped2", "softPopped3", "softPopped4", "softPopped5"]
    
    func popBubble() {
        if !isPopped {
            isPopped = true
            audioManager.startSound(sound: "popSound2", type: "mp3")
            HapticManager.impact(style: .rigid)
        }
    }
    
}
