//
//  NavigationGrid.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 25.07.2023.
//

import SwiftUI

struct NavigationGrid: View {
    
    var destination: AnyView
    var imageName: String
    var text: String
    var isAnimated: Bool
    var offset: CGFloat
    var delayTime: Double
    @State private var scaleEffectActive = false

    var body: some View {
        VStack {
            NavigationLink(destination: destination) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .scaleEffect(scaleEffectActive ? 1.05 : 1.0)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true).delay(delayTime)) {
                            self.scaleEffectActive.toggle()
                        }
                    }
            }
            Text(text)
                .font(Font.system(size: 24, weight: .thin, design: .rounded))
        }
        .opacity(isAnimated ? 1 : 0)
        .offset(y: isAnimated ? 0 : offset)
        .animation(.easeOut(duration: 1.5), value: isAnimated)
    }
}
