//
//  CatViewModel.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 14.08.2023.
//

import Foundation

class CatViewModel: ObservableObject {
    @Published var showHearts = false
    @Published var heartIDs = [UUID]()
    @Published var sliderHeartsIDs = [UUID]()
    @Published var counter = 1
    @Published var intensity: Double = 0
    @Published var showHelp: Bool = false
    @Published var sliderWidth: CGFloat = 0
    let audioManager = AudioManager()
    
    
    func startGesture() {
        showHearts = true
        HapticManager.startHaptics(intensityValue: Float(intensity))
        audioManager.startRepeatingSound(sound: "purring", type: "wav")
    }
    
    func endGesture() {
        showHearts = false
        heartIDs.removeAll()
        HapticManager.stopHaptics()
        audioManager.fadeOutAllSounds()
    }
    
    func onChangeSlider() {
        sliderHeartsIDs.append(UUID())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            if !sliderHeartsIDs.isEmpty {
                sliderHeartsIDs.removeFirst()
            }
        }
        HapticManager.impact(style: .light)
    }
    
    func viewAppeared() {
        HapticManager.prepareHaptics()
        showHelp = !UserDefaults.standard.bool(forKey: "CatView")
    }
    
}
