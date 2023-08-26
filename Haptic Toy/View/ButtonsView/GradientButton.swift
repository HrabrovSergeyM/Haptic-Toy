//
//  GradientButton.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 27.08.2023.
//

import SwiftUI

struct GradientButton: View {
    let gradientColors: [Color]
    let gradientAngle: GradientAngle
    let colorScheme: ColorScheme
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: gradientAngle.startPoint, endPoint: gradientAngle.endPoint))
                .cornerRadius(5)
                .shadow(color: .gray.opacity(0.15), radius: 3, x: 0, y: 0)
                .frame(width: isSelected ? 50 : 40, height: isSelected ? 50 : 40)
                .animation(.spring(), value: isSelected)
                .brightness(1.0 * 0.02 + (colorScheme == .light ? 0.28 : -0.26))
        }
    }
}

struct GradientButton_Previews: PreviewProvider {
    static var previews: some View {
        GradientButton(gradientColors: [.red, .blue], gradientAngle: GradientAngle(startPoint: .top, endPoint: .bottom), colorScheme: .light, isSelected: true, action: {})
    }
}
