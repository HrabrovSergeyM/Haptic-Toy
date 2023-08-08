//
//  ToggleView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//
// TODO: refactoring

import SwiftUI

struct ButtonsView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var showHelp: Bool = false
    @State var isStackVisible: Bool = false

    var body: some View {
        ZStack {
            Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
            VStack(spacing: 20) {
                ButtonsSection(isStackVisible: $isStackVisible, intensity: 0.6, baseOpacity: 0.1, offsetOpacity: 0.03, title: "Soft", yOffset: -40)
                ButtonsSection(isStackVisible: $isStackVisible, intensity: 0.8, baseOpacity: 0.3, offsetOpacity: 0.03, title: "Medium", yOffset: -60)
                ButtonsSection(isStackVisible: $isStackVisible, intensity: 1.0, baseOpacity: 0.5, offsetOpacity: 0.03, title: "Heavy", yOffset: -80)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ToolbarHelpButton(showHelp: $showHelp)
            }
        }
        .onAppear {
            showHelp = !UserDefaults.standard.bool(forKey: "ToggleView")
            withAnimation(.easeInOut(duration: 1)) {
                isStackVisible = true
            }
            HapticManager.prepareHaptics()
        }
        .sheet(isPresented: $showHelp, content: {
            HelpView(helpText: "helpViewToggle", screenKey: "ToggleView", isPresented: $showHelp)
        })
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
    }
}
