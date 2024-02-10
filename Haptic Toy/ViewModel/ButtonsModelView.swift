//
//  ButtonsModelView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.08.2023.
//

import Foundation

class ButtonsModelView: ObservableObject {
    @Published var sounds: [Sound] = [
        Sound(name: SoundType.breakingBass.name, tracks: SoundType.breakingBass.tracks),
        Sound(name: SoundType.feverNights.name, tracks: SoundType.feverNights.tracks),
        Sound(name: SoundType.acousticGuitar.name, tracks: SoundType.acousticGuitar.tracks),
        Sound(name: SoundType.studioBass.name, tracks: SoundType.studioBass.tracks)
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
