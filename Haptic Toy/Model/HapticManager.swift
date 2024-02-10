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
    
    static let initialIntensity: Float = 0.0
    static let intensityIncrement: Float = 0.1
    static let relativeTimeIncrement: Float = 1.0
    static let durationBeforeRepeat: TimeInterval = 2.0
    
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
            engine?.stoppedHandler = { reason in
                print("Engine stopped with reason: \(reason.rawValue)")
                if reason == .audioSessionInterrupt {
                    self.restartEngine()
                }
            }
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    private static func restartEngine() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            try self.engine?.start()
        } catch {
            print("Failed to restart the engine: \(error)")
        }
    }
    
    static func startHaptics(intensityValue: Float? = nil) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        for i in stride(from: initialIntensity, to: 1.0, by: intensityIncrement) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue ?? i)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: i)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: TimeInterval(i))
            events.append(event)
        }
        
        for i in stride(from: initialIntensity, to: 1.0, by: intensityIncrement) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue ?? Float(1.0 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1.0 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: Double(relativeTimeIncrement) + TimeInterval(i))
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
    
    static func playHapticWithIntensity(_ intensity: Float, sharpness: Float) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        let intensityParameter = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
        let sharpnessParameter = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensityParameter, sharpnessParameter], relativeTime: 0)
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine?.makeAdvancedPlayer(with: pattern)
            try player?.start(atTime: CHHapticTimeImmediate)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    private static func repeatHaptics() {
        DispatchQueue.main.asyncAfter(deadline: .now() + durationBeforeRepeat) {
            guard self.isPlaying else { return }
            try? self.player?.start(atTime: 0)
            self.repeatHaptics()
        }
    }
}
