//
//  NavigationGrid.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 25.07.2023.
//

import SwiftUI

struct NavigationGrid: View {
    
    var destination: String
    var imageName: String
    var text: String
    var isAnimated: Bool
    var offset: CGFloat
    var delayTime: Double
    var language = LocalizationService.shared.language
    @State private var scaleEffectActive = false
    var body: some View {
      
        VStack {
            NavigationLink(value: destination) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(scaleEffectActive ? 1.05 : 1.0)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true).delay(delayTime)) {
                            self.scaleEffectActive.toggle()
                        }
                    }
            }
            Text(text.localized(language))
                .font(Font.system(size: 24, weight: .thin, design: .rounded))
        }
        .opacity(isAnimated ? 1 : 0)
        .animation(.easeOut(duration: 1.5), value: isAnimated)
    }
}
