//
//  Haptic_ToyApp.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 23.07.2023.
//

import SwiftUI

@main
struct Haptic_ToyApp: App {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("appHasBeenLaunchedBefore") var appHasBeenLaunchedBefore: Bool = false
    
    @State private var showLaunchView: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showLaunchView {
                    LaunchView(showLaunchView: $showLaunchView)
                        .transition(.move(edge: .leading))
                        .zIndex(2.0)
                }
                HomeView()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
                    .accentColor(isDarkMode ? .white : .blue)
            }
            .onAppear {
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

