//
//  SettingsView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 04.08.2023.

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("isDarkIcon") var isDarkIcon: Bool = false
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    @State var isEng: Bool = LocalizationService.shared.language == .english_us
    
    @Binding var isShowingSettings: Bool

    var body: some View {
        ZStack {
            Color(UIColor.systemGray6).ignoresSafeArea()

            VStack(alignment: .center, spacing: 30) {
               
                
                DarkModeToggleView(isDarkMode: $isDarkMode)
                LanguageToggleView(isEng: $isEng)
                IconToggleView(isDarkIcon: $isDarkIcon)
                
                Button {
                    withAnimation {
                        isShowingSettings = false
                    }
                } label: {
                    Text("closeButton".localized(language))
                }
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

struct DarkModeToggleView: View {
    @Binding var isDarkMode: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 20) {
                Image(systemName: isDarkMode ? "sun.and.horizon" : "sun.max")
                    .font(.title)
                    .frame(width: 42, height: 42)
            Toggle("Dark Mode", isOn: $isDarkMode)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle())
            Image(systemName: isDarkMode ? "moon.stars" : "moon.zzz")
                .font(.title)
                .frame(width: 42, height: 42)
        }
    }
}

struct LanguageToggleView: View {
    @Binding var isEng: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Text("rus")
                .font(Font.system(size: 24, weight: .thin, design: .rounded))
                .frame(width: 42, height: 42)
            Toggle("Language", isOn: $isEng)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle())
                .onChange(of: isEng) { value in
                    LocalizationService.shared.language = value ? .english_us : .russian
                }
            Text("eng")
                .font(Font.system(size: 24, weight: .thin, design: .rounded))
                .frame(width: 42, height: 42)
        }
    }
}

struct IconToggleView: View {
    @Binding var isDarkIcon: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image("settingsLightIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
            Toggle("Icon", isOn: $isDarkIcon)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle())
                .onChange(of: isDarkIcon) { newValue in
                    changeAppIcon(isDarkIcon: newValue)
                }
            Image("settingsDarkIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
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
