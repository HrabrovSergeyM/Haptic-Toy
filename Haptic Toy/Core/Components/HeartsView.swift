//
//  HeartsView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

import SwiftUI

struct HeartsView: View {
    
    var id: Int
    @State private var opacity: Double = 1
    @State private var offset = CGSize.zero
    
    var body: some View {
       Image(systemName: "heart.fill")
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundColor(.red)
            .opacity(opacity)
            .offset(offset)
            .onAppear {
                withAnimation(Animation.easeOut(duration: 1)) {
                    offset = CGSize(width: Int.random(in: -50...50), height: -300)
                    opacity = 0.0
                }
            }
    }
}

