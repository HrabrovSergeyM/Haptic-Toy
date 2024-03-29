//
//  SettingsView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 04.08.2023.

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("isDarkIcon") var isDarkIcon: Bool = false
    @AppStorage(LocalizationService.languageKey)
    private var language = LocalizationService.shared.language
    @State var isEng: Bool = LocalizationService.shared.language == .english_us
    @State var showTheme: Bool = false
    @Binding var isShowingSettings: Bool
    @ObservedObject var theme = ColorThemeChangerService.shared
    var themes: [ColorTheme] = themeData
    
    var body: some View {
        ZStack {
            themes[self.theme.themeSettings].themePrimaryColor.ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 30) {
                
                DarkModeToggleView(isDarkMode: $isDarkMode)
                LanguageToggleView(isEng: $isEng)
                IconToggleView(isDarkIcon: $isDarkIcon)
                Button {
//                    HapticManager.impact(style: .soft)
                    withAnimation {
                        showTheme = true
//                        isShowingSettings = false
                    }
                } label: {
                    HStack {
                        Text("showThemesButton".localized(language))
                        Image(systemName: "chevron.right")
                    }
                        .font(Font.system(size: 20, weight: .thin, design: .rounded))
                        .foregroundColor(themes[self.theme.themeSettings].themeForegroundColor)
                }
               
                Button {
                    HapticManager.impact(style: .light)
                    withAnimation {
                        isShowingSettings = false
                    }
                } label: {
                    Text("closeButton".localized(language))
                        .font(Font.system(size: 20, weight: .thin, design: .rounded))
                        .foregroundColor(themes[self.theme.themeSettings].themeForegroundColor)
                }
            }
            .sheet(isPresented: $showTheme, content: {
                ColorThemeSelectorView(isShowingThemes: $showTheme)
            })
        }
    }
    
    private func changeAppIcon(isDarkIcon: Bool) {
        UIApplication.shared.setAlternateIconName(isDarkIcon ? "AppDarkIcon" : nil) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}

struct DarkModeToggleView: View {
    @Binding var isDarkMode: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Button {
                HapticManager.impact(style: .medium)
                isDarkMode = false
                
            } label: {
                Image(systemName: isDarkMode ? "sun.and.horizon" : "sun.max")
                    .font(.title)
                    .frame(width: 42, height: 42)
                    .foregroundColor(isDarkMode ? .gray.opacity(0.3) : .yellow)
            }
            .animation(.easeIn(duration: 0.5), value: isDarkMode)
            
            Toggle("Dark Mode", isOn: $isDarkMode)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle())
            
            Button {
                HapticManager.impact(style: .light)
                isDarkMode = true
            } label: {
                Image(systemName: isDarkMode ? "moon.stars" : "moon.zzz")
                    .font(.title)
                    .frame(width: 42, height: 42)
                    .foregroundColor(isDarkMode ? Color("moonColor") : .gray.opacity(0.3))
            }
            .animation(.easeIn(duration: 0.5), value: isDarkMode)
            
        }
    }
}

struct LanguageToggleView: View {
    @Binding var isEng: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Button {
                HapticManager.impact(style: .medium)
                isEng = false
            } label: {
                Text("🇷🇺")
                    .font(Font.system(size: 48, weight: .thin, design: .rounded))
                    .frame(width: 42, height: 42)
            }
            
            Toggle("Language", isOn: $isEng)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle())
                .onChange(of: isEng) { value in
                    LocalizationService.shared.language = value ? .english_us : .russian
                }
            
            Button {
                HapticManager.impact(style: .light)
                isEng = true
            } label: {
                Text("🇺🇸")
                    .font(Font.system(size: 48, weight: .thin, design: .rounded))
                    .frame(width: 42, height: 42)
            }
            
        }
    }
}

struct IconToggleView: View {
    @Binding var isDarkIcon: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Button {
                HapticManager.impact(style: .medium)
                isDarkIcon = false
            } label: {
                Image("settingsLightIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .cornerRadius(12)
            }
            
            Toggle("Icon", isOn: $isDarkIcon)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle())
                .onChange(of: isDarkIcon) { newValue in
                    changeAppIcon(isDarkIcon: newValue)
                }
            Button {
                HapticManager.impact(style: .light)
                isDarkIcon = true
            } label: {
                Image("settingsDarkIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .cornerRadius(12)
            }
            
        }
    }
    
    private func changeAppIcon(isDarkIcon: Bool) {
        UIApplication.shared.setAlternateIconName(isDarkIcon ? "AppDarkIcon" : nil) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isShowingSettings: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
