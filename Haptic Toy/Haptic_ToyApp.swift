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
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                     .preferredColorScheme(isDarkMode ? .dark : .light)
            } // NavigationStack
            .accentColor(isDarkMode ? .white : .blue)
        }
    }
}
