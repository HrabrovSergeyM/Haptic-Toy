//
//  SlidersView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

import SwiftUI

struct SlidersView: View {
    @AppStorage(LocalizationService.languageKey)
    var language = LocalizationService.shared.language
    
    @State var sliderValue: Double = 0
    @State var hapticStyle: HapticStyle = .soft
    @State var sliderTitle: String = "Soft"
    @State var titleWeight: Font.Weight = .thin
    @State var showHelp: Bool = false
    @ObservedObject var theme = ColorThemeChangerService.shared
    var themes: [ColorTheme] = themeData
    let value: String
    init(value: String) {
        self.value = value
        print("init: \(value)")
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        ZStack {
            
//            Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
            themes[self.theme.themeSettings].themeSecondaryColor.ignoresSafeArea()
            
            VStack(spacing: 20) {
                    Spacer()
                    Spacer()
                    Slider(value: $sliderValue, in: 0...1, step: 0.1)
                        .onChange(of: sliderValue) { newValue in
                            HapticManager.impact(style: hapticStyle.feedbackStyle)
                        }
//                        .foregroundColor(.red)
                        .accentColor(themes[self.theme.themeSettings].themeAccentColor)
                        
                    Text(sliderTitle)
                        .font(Font.system(size: 24, weight: titleWeight, design: .rounded))
                        .foregroundColor(themes[self.theme.themeSettings].themeForegroundColor)
                    Spacer()
                    Menu {
                        ForEach(HapticStyle.allCases, id: \.self) { style in
                            MenuButton(style: style, hapticStyle: $hapticStyle, sliderTitle: $sliderTitle, titleWeight: $titleWeight, sliderValue: $sliderValue)
                                
                        }
                    } label: {
                        Capsule()
                            .fill(themes[self.theme.themeSettings].themeAccentColor)
                            .cornerRadius(0)
//                            .foregroundColor(Color(colorScheme == .dark ? .systemGray4 : .white))
                            
                            .frame(width: 200, height: 75)
                            .overlay(alignment: .center, content: {
                                Text("sliderButton".localized(language))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(themes[self.theme.themeSettings].themeForegroundColor)
                                    .font(Font.system(size: 20, weight: .thin, design: .rounded))

                            })
                    }
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
//                    .foregroundColor(themes[self.theme.themeSettings].themeForegroundColor)
                    Spacer()
                }
                .padding(.horizontal, 80)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        ToolbarHelpButton(showHelp: $showHelp)
                    }
                }
                .onAppear {
                    showHelp = !UserDefaults.standard.bool(forKey: "SlidersView")
                }
                .sheet(isPresented: $showHelp, content: {
                    HelpView(helpText: "helpViewSliders", screenKey: "SlidersView", isPresented: $showHelp)
            })
        }
        
    }
}

struct SlidersView_Previews: PreviewProvider {
    static var previews: some View {
        SlidersView(value: "SliderView")
    }
}
