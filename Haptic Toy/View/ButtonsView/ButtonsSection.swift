//
//  ButtonsSection.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 08.08.2023.
//

import SwiftUI

struct ButtonsSection: View {
    private let audioManager = AudioManager.shared
    private let buttonCount = 5
    private let buttonSize: CGFloat = 50
    private let buttonSpacing: CGFloat = 20
    
    @Binding var isStackVisible: Bool
    @Binding var externalTrigger: ButtonPadTrigger?
    var intensity: Float
    var title: String
    var yOffset: CGFloat
    var brightness: Double
    var titleWeight: Font.Weight
    var rowIndex: Int
    @State private var isRippleActive: [Bool] = Array(repeating: false, count: 5)
    var selectedColor: Color
    var gradientColors: [Color]
    var selectedSound: [String]
    var gradientAngle: GradientAngle
    
    private var totalButtonsWidth: CGFloat {
        CGFloat(buttonCount) * buttonSize + CGFloat(buttonCount - 1) * buttonSpacing
    }
    
    private var buttonGradient: LinearGradient {
        let colors = gradientColors.isEmpty ? [selectedColor] : gradientColors
        return LinearGradient(gradient: Gradient(colors: colors),
                              startPoint: gradientAngle.startPoint,
                              endPoint: gradientAngle.endPoint)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(Font.system(size: 28, weight: titleWeight, design: .rounded))
            GeometryReader { geometry in
                HStack(spacing: buttonSpacing) {
                    ForEach(0..<buttonCount, id: \.self) { index in
                        ZStack {
                            backgroundButtons
                            buttons
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(buttonGradient,
                                        lineWidth: isRippleActive[index] ? 50 + Double(index) * Double(rowIndex) * 2.5 : 0)
                                .opacity(isRippleActive[index] ? 0.3 : 0)
                                .animation(.easeOut(duration: 0.5), value: isRippleActive[index])
                        )
                        .contentShape(Rectangle())
                        .background(
                            GeometryReader { buttonGeometry in
                                Color.clear.preference(
                                    key: ButtonPadPreferenceKey.self,
                                    value: [
                                        ButtonPadInfo(
                                            id: ButtonPadID(row: rowIndex, column: index),
                                            frame: buttonGeometry.frame(in: .named(ButtonsTouchSpace.name))
                                        )
                                    ]
                                )
                            }
                        )
                        .brightness(Double(1 - index) * 0.02 + brightness)
                    }
                }
                .frame(width: totalButtonsWidth, height: buttonSize)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                .contentShape(Rectangle())
            }
            .frame(height: buttonSize + 20)
            .onChange(of: externalTrigger) { newValue in
                guard let trigger = newValue, trigger.id.row == rowIndex else { return }
                handleInteraction(for: trigger.id.column)
            }
        }
        .opacity(isStackVisible ? 1 : 0)
        .offset(y: isStackVisible ? 0 : yOffset)
    }
    
    private func handleInteraction(for index: Int) {
        guard index >= 0, index < buttonCount else { return }
        
        let sharpnessValue = 1.0 - (Float(index) * 0.15)
        let soundIndex = rowIndex * buttonCount + index
        guard selectedSound.indices.contains(soundIndex) else { return }
        HapticManager.playHapticWithIntensity(intensity, sharpness: sharpnessValue)
        audioManager.startSound(sound: selectedSound[soundIndex], type: "mp3")
        
        withAnimation(.easeOut(duration: 0.5)) {
            isRippleActive[index] = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.easeOut(duration: 0.35)) {
                isRippleActive[index] = false
            }
        }
    }
}

extension ButtonsSection {
    
    private var backgroundButtons: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(buttonGradient)
            .shadow(color: .gray.opacity(0.35), radius: 3,
                    x: 0,
                    y: 0
            )
            .frame(width: buttonSize, height: buttonSize)
    }
    
    private var buttons: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(buttonGradient)
            .shadow(color: .gray.opacity(0.15), radius: 2, x: 0, y: 0)
        
            .frame(width: buttonSize, height: buttonSize)

    }
    
}

struct ButtonPadID: Hashable {
    let row: Int
    let column: Int
}

struct ButtonPadInfo: Equatable {
    let id: ButtonPadID
    let frame: CGRect
}

struct ButtonPadTrigger: Equatable {
    let id: ButtonPadID
    private let token = UUID()
    
    static func == (lhs: ButtonPadTrigger, rhs: ButtonPadTrigger) -> Bool {
        lhs.token == rhs.token
    }
}

struct ButtonPadPreferenceKey: PreferenceKey {
    static var defaultValue: [ButtonPadInfo] = []
    
    static func reduce(value: inout [ButtonPadInfo], nextValue: () -> [ButtonPadInfo]) {
        value.append(contentsOf: nextValue())
    }
}

enum ButtonsTouchSpace {
    static let name = "ButtonsTouchSpace"
}
