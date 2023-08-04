//
//  BubbleView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 30.07.2023.
//

import SwiftUI

struct BubbleView: View {
    
    @Binding var restartKey: Bool
    @Binding var displayMode: DisplayMode
    
    var body: some View {
        let bubbleRows: Int
        let bubblesPerRow: Int
        
        switch displayMode {
        case .standard:
            bubbleRows = 10
            bubblesPerRow = 4
        case .extended:
            bubbleRows = 15
            bubblesPerRow = 6
        case .maximum:
            bubbleRows = 19
            bubblesPerRow = 9
        }
        
        return ZStack {
            VStack {
                ForEach(0..<bubbleRows, id: \.self) { index in
                    HStack {
                        ForEach(0..<(index % 2 == 0 ? bubblesPerRow : bubblesPerRow + 1), id: \.self) { _ in
                            Bubble(restartKey: $restartKey, displayMode: $displayMode)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct Bubble: View {
    @State var isPopped: Bool = false
    @Binding var restartKey: Bool
    @Binding var displayMode: DisplayMode
    
    var soundEffects: [String] = ["popBubble1", "popBubble2"]
    
    var prepopped: [String] = ["softPrepopped", "softPrepopped2", "softPrepopped3", "softPrepopped4"]
    var popped: [String] = ["softPopped", "softPopped2", "softPopped3", "softPopped4", "softPopped5"]
    
    var body: some View {
        Image((isPopped ? popped.randomElement() : prepopped.randomElement())!)
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.primary)
            .scaledToFit()
            .onTapGesture {
                if !isPopped {
                    isPopped = true
                    startSound(sound: "pop", type: "mp3")
                    HapticManager.impact(style: .rigid)
                }
            }
            .onChange(of: restartKey) { newValue in
                withAnimation(.easeOut) {
                    isPopped = false
                }
            }
            .onChange(of: displayMode) { newValue in
                withAnimation(.easeOut) {
                    isPopped = false
                }
            }
        
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(restartKey: .constant(false), displayMode: .constant(.standard))
    }
}
