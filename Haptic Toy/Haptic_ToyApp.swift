//
//  Haptic_ToyApp.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 23.07.2023.
//

import SwiftUI

@main
struct Haptic_ToyApp: App {
    @AppStorage("nativeLanguage") var nativeLanguage = Locale.current.language.languageCode?.identifier == LocalizationService.shared.language.rawValue ? "en" : "ru"
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("appHasBeenLaunchedBefore") var appHasBeenLaunchedBefore: Bool = false
    
//    @AppStorage("language")
//    var language = Locale.current.language.languageCode?.identifier ?? LocalizationService.shared.language.rawValue
    

    @State private var showLaunchView: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack {
                    ContentView()
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                        .navigationBarBackButtonHidden()
                } // NavigationStack
                .accentColor(isDarkMode ? .white : .blue)
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                } // ZStack
                .zIndex(2.0)
            } // ZStack
            .onAppear {
                print(nativeLanguage)
                if !appHasBeenLaunchedBefore {
                    if UITraitCollection.current.userInterfaceStyle == .dark {
                        isDarkMode = true
                    } else {
                        isDarkMode = false
                    }
                    appHasBeenLaunchedBefore = true
                }
            }
        }
    }
}

