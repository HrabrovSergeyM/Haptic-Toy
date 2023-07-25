//
//  HapticManager.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 23.07.2023.
//

import Foundation
import SwiftUI
import CoreHaptics

class HapticManager {
    
    static var engine: CHHapticEngine?
    static var player: CHHapticAdvancedPatternPlayer?
    static var isPlaying: Bool = false
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
         let generator = UINotificationFeedbackGenerator()
         generator.notificationOccurred(type)
     }
     
     static func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
         let generator = UIImpactFeedbackGenerator(style: style)
         generator.impactOccurred()
     }

    static func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
//    static func startHaptics() {
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//        var events = [CHHapticEvent]()
//
//        for i in stride(from: 0, to: 1, by: 0.1) {
//            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
//            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
//            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
//            events.append(event)
//        }
//
//        for i in stride(from: 0, to: 1, by: 0.1) {
//            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
//            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
//            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
//            events.append(event)
//        }
//
//        do {
//            let pattern = try CHHapticPattern(events: events, parameters: [])
//            self.player = try engine?.makeAdvancedPlayer(with: pattern)
//            try player?.start(atTime: 0)
//            isPlaying = true
//            repeatHaptics()
//        } catch {
//            print("Failed to play pattern: \(error.localizedDescription).")
//        }
//    }
    
    static func startHaptics(intensityValue: Float? = nil) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue ?? Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue ?? Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }

        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            self.player = try engine?.makeAdvancedPlayer(with: pattern)
            try player?.start(atTime: 0)
            isPlaying = true
            repeatHaptics()
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }

    static func stopHaptics() {
        self.isPlaying = false
        do {
            try self.player?.stop(atTime: 0)
        } catch {
            print("Failed to stop haptics: \(error.localizedDescription)")
        }
    }
    
    private static func repeatHaptics() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard self.isPlaying else { return }
            try? self.player?.start(atTime: 0)
            self.repeatHaptics()
        }
    }
}
