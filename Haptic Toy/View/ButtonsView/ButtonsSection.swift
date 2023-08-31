//
//  ButtonsSection.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 08.08.2023.
//

import SwiftUI
import CoreMotion


struct ButtonsSection: View {
    let audioManager = AudioManager()
    @Binding var isStackVisible: Bool
    @Binding var motion: CMDeviceMotion?
    let motionManager: CMMotionManager
    var intensity: Float
    var title: String
    var yOffset: CGFloat
    var brightness: Double
    var titleWeight: Font.Weight
    var rowIndex: Int
    @State var isRippleActive: [Bool] = Array(repeating: false, count: 5)
    var selectedColor: Color
    var gradientColors: [Color]
    var selectedSound: [String]
    var gradientAngle: GradientAngle
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(Font.system(size: 28, weight: titleWeight, design: .rounded))
            HStack(spacing: 20) {
                ForEach(0..<5) { index in
                    Button(action: {
                        let sharpnessValue = 1.0 - (Float(index) * 0.15)
                        let soundIndex = rowIndex * 5 + index
                        HapticManager.playHapticWithIntensity(intensity, sharpness: sharpnessValue)
                        
                        audioManager.startSound(sound: selectedSound[soundIndex], type: "mp3")
                        
                        withAnimation {
                            isRippleActive[index].toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    isRippleActive[index] = false
                                }
                            }
                        }
                    }) {
                        ZStack {
                            backgroundButtons
                            buttons
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: gradientAngle.startPoint, endPoint: gradientAngle.endPoint), lineWidth: isRippleActive[index] ? 50 + Double(index) * Double(rowIndex) * 2.5 : 0)
                                .opacity(isRippleActive[index] ? 0.3 : 0)
                                .animation(.easeOut(duration: 0.5), value: isRippleActive[index])
                        )
                    }
                    
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
            .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: gradientAngle.startPoint, endPoint: gradientAngle.endPoint))
            .shadow(color: .gray.opacity(0.35), radius: 3,
                    x: 0,
                    y: 0
            )
            .frame(width: 50, height: 50)
        
        //            .offset(
        //                x: motion != nil ? CGFloat(motion!.gravity.x * 4) : 0,
        //                y: motion != nil ? CGFloat(-motion!.gravity.y * 4) : 0
        //            )
        //            .rotation3DEffect(
        //                motion != nil ? .degrees(Double(motion!.attitude.pitch) * 3 / .pi) : .degrees(0),
        //                axis: (
        //                    x: motion != nil ? -motion!.gravity.y : 0,
        //                    y: motion != nil ? motion!.gravity.x : 0,
        //                    z: 0)
        //            )
    }
    
    private var buttons: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: gradientAngle.startPoint, endPoint: gradientAngle.endPoint))
            .shadow(color: .gray.opacity(0.15), radius: 2, x: 0, y: 0)
        
            .frame(width: 50, height: 50)
        //            .offset(
        //                x: motion != nil ? CGFloat(motion!.gravity.x * 5) : 0,
        //                y: motion != nil ? CGFloat(-motion!.gravity.y * 5) : 0
        //            )
        //            .rotation3DEffect(
        //                motion != nil ? .degrees(Double(motion!.attitude.pitch) * 5 / .pi) : .degrees(0),
        //                axis: (
        //                    x: motion != nil ? -motion!.gravity.y : 0,
        //                    y: motion != nil ? motion!.gravity.x : 0,
        //                    z: 0)
        //            )
    }
    
}
