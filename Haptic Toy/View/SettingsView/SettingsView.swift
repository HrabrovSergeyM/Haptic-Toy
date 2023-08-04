//
//  SettingsView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 04.08.2023.
//"moon.circle.fill" : "moon.circle"

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State var isEng: Bool = LanguageManager.language == "en"
    @State var isDarkIcon: Bool = false
    @Binding var isShowingSettings: Bool
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6).ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                HStack {
                    Image(systemName: "sun.max")
                        .font(.title2)
                    Toggle("Dark Mode", isOn: $isDarkMode)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle())
                    //                        .onChange(of: isDarkMode) { value in
                    //                            isDarkMode.toggle()
                    //                        }
                    Image(systemName: "moon.circle.fill")
                        .font(.title2)
                }
                
                HStack {
                    Text("rus")
                        .font(Font.system(size: 24, weight: .thin, design: .rounded))
                    Toggle("Dark Mode", isOn: $isEng)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle())
                        .onChange(of: isEng) { value in
                            LanguageManager.language = value ? "en" : "ru"
                        }
                    Text("eng")
                        .font(Font.system(size: 24, weight: .thin, design: .rounded))
                }
                
                HStack {
                    Image("settingsDarkIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    Toggle("Dark Mode", isOn: $isDarkIcon)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle())
                    Image("settingsLightIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                }
                Button {
                    withAnimation {
                        isShowingSettings = false
                    }
                } label: {
                    Text("Close")
                }
                
            }
            .toolbar {
                ToolbarItem {
                    
                }
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
