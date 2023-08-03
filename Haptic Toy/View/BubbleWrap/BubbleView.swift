//
//  BubbleView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 30.07.2023.
//

import SwiftUI

struct BubbleView: View {
    
    @Binding var restartKey: Bool
    
    var body: some View {
        ZStack {
            //            Color("BubbleWrapBackground").ignoresSafeArea()
            //            Color(.white).ignoresSafeArea()
            VStack {
                ForEach(0..<10) { index in
                    if index % 2 > 0 {
                        HStack {
                            ForEach(0..<5) { _ in
                                Bubble(restartKey: $restartKey)
                            }
                        }
                    } else {
                        HStack {
                            ForEach(0..<4) { _ in
                                Bubble(restartKey: $restartKey)
                            }
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
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(restartKey: .constant(false))
    }
}
