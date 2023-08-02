//
//  BubbleView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 30.07.2023.
//

import SwiftUI

struct BubbleView: View {
    var body: some View {
        ZStack {
            //            Color("BubbleWrapBackground").ignoresSafeArea()
            //            Color(.white).ignoresSafeArea()
            VStack {
                ForEach(0..<10) { index in
                    if index % 2 > 0 {
                        HStack {
                            ForEach(0..<5) { _ in
                                Bubble()
                            }
                        }
                    } else {
                        HStack {
                            ForEach(0..<4) { _ in
                                Bubble()
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
                //                withAnimation(.easeIn) {
                
                if !isPopped {
                    isPopped = true
                    startSound(sound: "pop", type: "mp3")
                    HapticManager.impact(style: .medium)
                    //                    }
                }
            }
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView()
    }
}
