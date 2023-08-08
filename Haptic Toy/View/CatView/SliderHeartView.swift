//
//  SliderHeartView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 08.08.2023.
//

import SwiftUI

struct SliderHeartView: View {
    
    let id: UUID
    let startPosition: CGPoint
    
    @State private var randomXOffset: CGFloat = CGFloat.random(in: -30...30)
    @State private var endPositionY: CGFloat = 60
    
    var body: some View {
        Image(systemName: "heart.fill")
            .resizable()
            .frame(width: 15, height: 15)
            .foregroundColor(.red)
            .position(x: startPosition.x + randomXOffset, y: startPosition.y + endPositionY)
            .opacity(0.8)
            .onAppear {
                withAnimation(Animation.easeOut(duration: 1)) {
                    endPositionY += CGFloat.random(in: 20...60)
                    randomXOffset *= 1.5
                }
            }
    }
}
