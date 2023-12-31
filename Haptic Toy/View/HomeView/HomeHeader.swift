//
//  HomeHeader.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 06.08.2023.
//

import SwiftUI

struct HomeHeader: View {
    @Binding var isShowingSettings: Bool
    var language = LocalizationService.shared.language
    @ObservedObject var theme = ColorThemeChangerService.shared
    var themes: [ColorTheme] = themeData
    
    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .fill(themes[self.theme.themeSettings].themePrimaryColor).ignoresSafeArea()
            .frame(height: 60)
            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 2)
            .overlay(
                HStack {
                    Spacer()
                    Spacer()
                    Text("greeting_text".localized(language))
                        .font(Font.system(size: 28, weight: .thin, design: .rounded))
                        .foregroundColor(themes[self.theme.themeSettings].themeForegroundColor)
                    Spacer()
                    Button {
                        isShowingSettings.toggle()
                        HapticManager.notification(type: .success)
                    } label: {
                        Image(systemName: "gearshape")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(themes[self.theme.themeSettings].themeForegroundColor)
                    }
                    .padding(.horizontal)
                }
                
            )
            .padding(.bottom, 0)
            .zIndex(2)
    }
}

struct HomeHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeader(isShowingSettings: .constant(false))
    }
}
