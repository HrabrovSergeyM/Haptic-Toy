//
//  Bubble.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 15.08.2023.
//

import Foundation
import SwiftUI

struct Bubble: View {
    private let audioManager = AudioManager.shared
    private let foregroundColor: Color
    
    @State private var isPopped: Bool = false
    @State private var imageName: String
    
    @Binding var restartKey: Bool
    @Binding var displayMode: DisplayMode
    
    init(restartKey: Binding<Bool>, displayMode: Binding<DisplayMode>, foregroundColor: Color) {
        self._restartKey = restartKey
        self._displayMode = displayMode
        self.foregroundColor = foregroundColor
        _imageName = State(initialValue: BubbleAsset.randomPrepopped())
    }
    
    var body: some View {
        Image(imageName)
            .resizable()
            .renderingMode(.template)
            .foregroundColor(foregroundColor)
            .scaledToFit()
            .onTapGesture {
                popBubble()
            }
            .onChange(of: restartKey) { _ in
                resetBubble()
            }
            .onChange(of: displayMode) { _ in
                resetBubble()
            }
    }
    
    private func popBubble() {
        guard !isPopped else { return }
        isPopped = true
        imageName = BubbleAsset.randomPopped()
        audioManager.startSound(sound: SoundName.popSound2, type: "mp3")
        HapticManager.impact(style: .rigid)
    }
    
    private func resetBubble() {
        isPopped = false
        imageName = BubbleAsset.randomPrepopped()
    }
}

struct Bubble_Previews: PreviewProvider {
    static var previews: some View {
        Bubble(restartKey: .constant(false), displayMode: .constant(.standard), foregroundColor: .blue)
    }
}
