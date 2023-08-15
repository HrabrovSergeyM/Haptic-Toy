//
//  Bubble.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 15.08.2023.
//

import Foundation
import SwiftUI

struct Bubble: View {
    @ObservedObject var bubbleViewModel: BubbleViewModel = BubbleViewModel()
    @Binding var restartKey: Bool
    @Binding var displayMode: DisplayMode
    
    var body: some View {
        Image((bubbleViewModel.isPopped ? bubbleViewModel.popped.randomElement() : bubbleViewModel.prepopped.randomElement())!)
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.primary)
            .scaledToFit()
            .onTapGesture {
                bubbleViewModel.popBubble()
            }
            .onChange(of: restartKey) { newValue in
                withAnimation(.easeOut) {
                    bubbleViewModel.isPopped = false
                }
            }
            .onChange(of: displayMode) { newValue in
                withAnimation(.easeOut) {
                    bubbleViewModel.isPopped = false
                }
            }
        
    }
}

struct Bubble_Previews: PreviewProvider {
    static var previews: some View {
        Bubble(restartKey: .constant(false), displayMode: .constant(.standard))
    }
}

