//
//  ButtonsSection.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 08.08.2023.
//

import SwiftUI
import CoreMotion

struct ButtonsSection: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var isStackVisible: Bool
    @Binding var motion: CMDeviceMotion?
    let motionManager: CMMotionManager
    var intensity: Float
    var baseOpacity: Double
    var offsetOpacity: Double
    var title: String
    var yOffset: CGFloat
    
    private func getColor(color: Color, forIndex index: Int, baseOpacity: Double, offsetOpacity: Double) -> Color {
        let returnedColor =
        colorScheme == .light ?
        color.opacity(Double(index + 1) * 0.03 + offsetOpacity) :
        color.opacity(Double(1 - index) * 0.08 + offsetOpacity)
        
        return returnedColor
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(Font.system(size: 28, weight: .medium, design: .rounded))
            HStack(spacing: 20) {
                ForEach(0..<5) { index in
                    Button(action: {
                        let sharpnessValue = 1.0 - (Float(index) * 0.15)
                        HapticManager.playHapticWithIntensity(intensity, sharpness: sharpnessValue)
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(UIColor.tertiarySystemBackground))
                                .shadow(color: getColor(color: Color("ColorGray"), forIndex: index, baseOpacity: baseOpacity, offsetOpacity: offsetOpacity), radius: 4, x: 0, y: 0)
                                .frame(width: 50, height: 50)
                            
                                .offset(
                                    x: motion != nil ? CGFloat(motion!.gravity.x * 18) : 0,
                                    y: motion != nil ? CGFloat(-motion!.gravity.y * 18) : 0
                                )
                                .rotation3DEffect(
                                    motion != nil ? .degrees(Double(motion!.attitude.pitch) * 3 / .pi) : .degrees(0),
                                    axis: (
                                        x: motion != nil ? -motion!.gravity.y : 0,
                                        y: motion != nil ? motion!.gravity.x : 0,
                                        z: 0)
                                )
                            RoundedRectangle(cornerRadius: 5)
                                .fill(getColor(color: Color("ColorGray"), forIndex: index, baseOpacity: baseOpacity, offsetOpacity: offsetOpacity))
                                .shadow(color: .primary.opacity(0.4), radius: 4, x: 0, y: 0)
                                .frame(width: 50, height: 50)
                                .offset(
                                    x: motion != nil ? CGFloat(motion!.gravity.x * 20) : 0,
                                    y: motion != nil ? CGFloat(-motion!.gravity.y * 20) : 0
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
                    
                }
            }
        }
        .opacity(isStackVisible ? 1 : 0)
        .offset(y: isStackVisible ? 0 : yOffset)
    }
}


struct ButtonsSection_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ButtonsSection(isStackVisible: .constant(true), motion: .constant(.none), motionManager: CMMotionManager(), intensity: (0.6), baseOpacity: (0.3), offsetOpacity: (0.03), title: ("Soft"), yOffset: (40))
            ButtonsSection(isStackVisible: .constant(true), motion: .constant(.none), motionManager: CMMotionManager(), intensity: (0.8), baseOpacity: (0.5), offsetOpacity: (0.03), title: ("Medium"), yOffset: (40))
            ButtonsSection(isStackVisible: .constant(true), motion: .constant(.none), motionManager: CMMotionManager(), intensity: (1.0), baseOpacity: (0.7), offsetOpacity: (0.03), title: ("Heavy"), yOffset: (40))
        }
    }
}
