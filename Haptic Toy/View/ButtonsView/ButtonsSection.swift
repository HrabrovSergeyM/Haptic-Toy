//
//  ButtonsSection.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 08.08.2023.
//

import SwiftUI

struct ButtonsSection: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var isStackVisible: Bool
     var intensity: Float
     var baseOpacity: Double
     var offsetOpacity: Double
     var title: String
     var yOffset: CGFloat
    
    private func getColor(forIndex index: Int, baseOpacity: Double, offsetOpacity: Double) -> Color {
        let opacity = colorScheme == .light ?
            baseOpacity + (Double(index + 1) * offsetOpacity) :
            baseOpacity + (Double(1 - index) * offsetOpacity)
        return Color("ColorGray").opacity(opacity)
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
                        RoundedRectangle(cornerRadius: 5)
                            .fill(getColor(forIndex: index, baseOpacity: baseOpacity, offsetOpacity: offsetOpacity))
                            .shadow(color: .primary.opacity(0.4), radius: 4, x: 0, y: 0)
                            .frame(width: 50, height: 50)
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
        ButtonsSection(isStackVisible: .constant(true), intensity: (0.5), baseOpacity: (0.5), offsetOpacity: (0.5), title: ("Soft"), yOffset: (40))
    }
}
