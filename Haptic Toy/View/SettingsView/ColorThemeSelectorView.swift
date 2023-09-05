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
    @Binding var isShowingThemes: Bool
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
                                isShowingThemes = false
                            } label: {
                                ColorThemePreview(image: theme.themePreview)
                                    .shadow(
                                        color: .black.opacity(self.theme.themeSettings == theme.id ? 0.55 : 0.35),
                                        radius: self.theme.themeSettings == theme.id ? 10 : 6,
                                        x: 0,
                                        y: 0)
                                    .scaleEffect(self.theme.themeSettings == theme.id ? 1.05 : 1.0)
                            }
                            .animation(.spring(response: 0.9, dampingFraction: self.theme.themeSettings <= 1 ? 0.55 : 0.525, blendDuration: 0.8), value: isAnimated)
                            
                        } // ForEach
                        .offset(y: isAnimated ? 0 : 360)
                        .foregroundColor(themes[self.theme.themeSettings].themeForegroundColor)
                        
                    }
                    .padding()
                    .padding(.top, 40)
            }
            
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    withAnimation {
                        isAnimated = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    HapticManager.impact(style: .soft)
                }
            }
        }
    }
}

struct ColorThemeSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorThemeSelectorView(isShowingThemes: .constant(true))
    }
}
