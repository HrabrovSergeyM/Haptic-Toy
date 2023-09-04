//
//  ColorThemeSelectorView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 01.09.2023.
//

import SwiftUI

struct ColorThemeSelectorView: View {
    
    @ObservedObject var theme = ColorThemeChangerService.shared
    var themes: [ColorTheme] = themeData
    let spacing: CGFloat = 40
    @Binding var isThemesShown: Bool
    @State var isAnimated: Bool = false
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ZStack {
            
            themes[self.theme.themeSettings].themePrimaryColor.opacity(0.7).ignoresSafeArea()
            
            ScrollView {
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: spacing,
                    pinnedViews: []) {
                        ForEach(themes, id: \.id) { theme in
                            Button {
                                HapticManager.impact(style: .soft)
                                withAnimation(.linear(duration: 0.5)) {
                                    self.theme.themeSettings = theme.id
                                }
                                UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                            } label: {
                                ColorThemePreview(image: theme.themePreview)
                                    .shadow(
                                        color: .black.opacity(self.theme.themeSettings == theme.id ? 0.55 : 0.35),
                                        radius: self.theme.themeSettings == theme.id ? 10 : 6,
                                        x: 0,
                                        y: 0)
                                    .scaleEffect(self.theme.themeSettings == theme.id ? 1.05 : 1.0)
                                
                                
                            }
                            
                        } // ForEach
                        .offset(y: isAnimated ? 0 : 360)
                        .foregroundColor(themes[self.theme.themeSettings].themeForegroundColor)
                        
                    }
                    .padding()
                    .padding(.top, 40)
            }
            .animation(.spring(response: 0.9, dampingFraction: 0.6, blendDuration: 0.8), value: isAnimated)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    withAnimation {
                        isAnimated = true
                    }
                }
            }
        }
    }
}

struct ColorThemeSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorThemeSelectorView(isThemesShown: .constant(true))
    }
}
