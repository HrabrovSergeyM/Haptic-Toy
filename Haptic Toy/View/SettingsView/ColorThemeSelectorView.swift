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
    let spacing: CGFloat = 10
    @Binding var isSelected: Bool
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ZStack {
            themes[self.theme.themeSettings].themePrimaryColor.opacity(0.7).ignoresSafeArea()
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 10,
                pinnedViews: []) {
                    ForEach(themes, id: \.id) { theme in
                        Button {
                            withAnimation(.linear(duration: 0.5)) {
                                self.theme.themeSettings = theme.id
                            }
                            UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                        } label: {
                            ColorThemePreview(lightImage: theme.lightImage, darkImage: theme.darkImage)
                        }

                    } // ForEach
                    .foregroundColor(themes[self.theme.themeSettings].themeForegroundColor)
                    
                }
                .padding()
          
        }
    }
}

struct ColorThemeSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorThemeSelectorView(isSelected: .constant(true))
    }
}
