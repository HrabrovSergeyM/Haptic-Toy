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
    
    @State private var engine: CHHapticEngine?
    
//    static private
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    static func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    

    
    func prepareHaptics() {
       guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
       
       do {
           engine = try CHHapticEngine()
           try engine?.start()
       } catch  {
           print(error.localizedDescription)
       }
   }
    
    func complexSucces() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch  {
            print(error.localizedDescription)
        }
        
   }
    
 
    
    
    
}
