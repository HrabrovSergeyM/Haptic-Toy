//
//  PaletteView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.08.2023.
//

import SwiftUI

struct PaletteView: View {
    @Binding var isShowingPalette: Bool
    @Binding var selectedColor: Color
    
    let colors: [Color] = [
        .purple, .red, .pink,
        .yellow, .mint, .green,
        .blue, .indigo, .gray
    ]
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6).ignoresSafeArea()
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
                ForEach(colors, id: \.self) { color in
                    Button(action: {
                        self.selectedColor = color
                        self.isShowingPalette = false
                    }) {
                        Rectangle()
                            .fill(color)
                            .frame(width: 50, height: 50)
                            
                    }
                }
            }
            .padding(100)
        }
    }
}

struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteView(isShowingPalette: .constant(true), selectedColor: .constant(.gray))
    }
}
