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
    var language = LocalizationService.shared.language
    let colors: [Color] = [
        .purple, .red, .pink,
        .yellow, .mint, .green,
        .blue, .indigo, .gray
    ]
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6).ignoresSafeArea()
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
                    ForEach(colors, id: \.self) { color in
                        Button(action: {
                            self.selectedColor = color
                                UserDefaults.standard.setColor(color: UIColor(color), forKey: "selectedColor")
                                self.isShowingPalette = false
                        }) {
                            Rectangle()
                                .fill(color)
                                .cornerRadius(8)
                                .shadow(color: color.opacity(0.15), radius: 2, x: 0, y: 0)
                                .frame(width: 50, height: 50)
                        }
                    }
                }
                .padding(40)
                Button {
                    withAnimation {
                        isShowingPalette = false
                    }
                } label: {
                    Text("closeButton".localized(language))
                }
            }
           
        }
    }
}

struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteView(isShowingPalette: .constant(true), selectedColor: .constant(.gray))
    }
}
