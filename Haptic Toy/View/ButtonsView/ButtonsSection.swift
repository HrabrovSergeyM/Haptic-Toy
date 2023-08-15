//
//  ButtonsSection.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 08.08.2023.
//

import SwiftUI
import CoreMotion

struct ButtonsSection: View {
    
    @Binding var isStackVisible: Bool
    @Binding var motion: CMDeviceMotion?
    let motionManager: CMMotionManager
    var intensity: Float
    var title: String
    var yOffset: CGFloat
    var brightness: Double
    var titleWeight: Font.Weight
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(Font.system(size: 28, weight: titleWeight, design: .rounded))
            HStack(spacing: 20) {
                ForEach(0..<5) { index in
                    Button(action: {
                        let sharpnessValue = 1.0 - (Float(index) * 0.15)
                        HapticManager.playHapticWithIntensity(intensity, sharpness: sharpnessValue)
                    }) {
                        ZStack {
                            backgroundButtons
                            buttons
                        }
                    } // Button
                    .brightness(Double(1 - index) * 0.02 + brightness)
                }
            }
        }
        .opacity(isStackVisible ? 1 : 0)
        .offset(y: isStackVisible ? 0 : yOffset)
    }
}

extension ButtonsSection {
    
    private var backgroundButtons: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color("ColorGray"))
            .shadow(color: .primary.opacity(0.35), radius: 3,
                    x: motion != nil ? CGFloat(-motion!.gravity.x * 4) : 0,
                    y: motion != nil ? CGFloat(motion!.gravity.y * 2) : 0
            )
            .frame(width: 50, height: 50)
        
            .offset(
                x: motion != nil ? CGFloat(motion!.gravity.x * 4) : 0,
                y: motion != nil ? CGFloat(-motion!.gravity.y * 4) : 0
            )
            .rotation3DEffect(
                motion != nil ? .degrees(Double(motion!.attitude.pitch) * 3 / .pi) : .degrees(0),
                axis: (
                    x: motion != nil ? -motion!.gravity.y : 0,
                    y: motion != nil ? motion!.gravity.x : 0,
                    z: 0)
            )
    }
    
    private var buttons: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color("ColorGray"))
            .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 0)
        
            .frame(width: 50, height: 50)
            .offset(
                x: motion != nil ? CGFloat(motion!.gravity.x * 5) : 0,
                y: motion != nil ? CGFloat(-motion!.gravity.y * 5) : 0
            )
            .rotation3DEffect(
                motion != nil ? .degrees(Double(motion!.attitude.pitch) * 5 / .pi) : .degrees(0),
                axis: (
                    x: motion != nil ? -motion!.gravity.y : 0,
                    y: motion != nil ? motion!.gravity.x : 0,
                    z: 0)
            )
    }
    
}
