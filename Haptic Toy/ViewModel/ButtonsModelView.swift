//
//  ButtonsModelView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.08.2023.
//

import Foundation

class ButtonsModelView: ObservableObject {
    @Published var sounds: [Sound] = [
        Sound(name: "Breaking Bass", tracks: ["breakingBass0", "breakingBass1", "breakingBass2", "breakingBass3", "breakingBass4", "breakingBass5", "breakingBass6", "breakingBass7", "breakingBass8", "breakingBass9", "breakingBass10", "breakingBass11", "breakingBass12", "breakingBass13", "breakingBass14"]),
        Sound(name: "Fever Nights", tracks: ["feverNights0", "feverNights1", "feverNights2", "feverNights3", "feverNights4", "feverNights5", "feverNights6", "feverNights7", "feverNights8", "feverNights9", "feverNights10", "feverNights11", "feverNights12", "feverNights13", "feverNights14"]),
        Sound(name: "Acoustic Guitar", tracks: ["acousticGuitar0", "acousticGuitar1", "acousticGuitar2", "acousticGuitar3", "acousticGuitar4", "acousticGuitar5", "acousticGuitar6", "acousticGuitar7", "acousticGuitar8", "acousticGuitar9", "acousticGuitar10", "acousticGuitar11", "acousticGuitar12", "acousticGuitar13", "acousticGuitar14"]),
        Sound(name: "Studio Bass", tracks: ["studioBass0", "studioBass1", "studioBass2", "studioBass3", "studioBass4", "studioBass5", "studioBass6", "studioBass7", "studioBass8", "studioBass9", "studioBass10", "studioBass11", "studioBass12", "studioBass13", "studioBass14"])
    ]
    @Published var gradientAngles: [GradientAngle] = [
        GradientAngle(startPoint: .topLeading, endPoint: .bottomTrailing),
        GradientAngle(startPoint: .top, endPoint: .bottom),
        GradientAngle(startPoint: .topTrailing, endPoint: .bottomLeading),
        GradientAngle(startPoint: .bottomLeading, endPoint: .topTrailing),
        GradientAngle(startPoint: .bottom, endPoint: .top),
        GradientAngle(startPoint: .top, endPoint: .bottomTrailing)
    ]
    @Published var isShowingPalette: Bool = false
    @Published var isShowingSoundBar: Bool = false
}
