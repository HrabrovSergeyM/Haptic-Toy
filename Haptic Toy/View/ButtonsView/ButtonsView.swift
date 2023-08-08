//
//  ToggleView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//
// TODO: refactoring

import SwiftUI
import CoreMotion

struct ButtonsView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var showHelp: Bool = false
    @State var isStackVisible: Bool = false
    
    let motionManager = CMMotionManager()
    @State var motion: CMDeviceMotion? = nil

    var body: some View {
        ZStack {
            Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
            VStack(spacing: 20) {
                ButtonsSection(isStackVisible: $isStackVisible, motion: $motion, motionManager: motionManager, intensity: 0.6, baseOpacity: 0.1, offsetOpacity: 0.03, title: "Soft", yOffset: -40)
                ButtonsSection(isStackVisible: $isStackVisible, motion: $motion, motionManager: motionManager, intensity: 0.8, baseOpacity: 0.3, offsetOpacity: 0.03, title: "Medium", yOffset: -60)
                ButtonsSection(isStackVisible: $isStackVisible, motion: $motion, motionManager: motionManager, intensity: 1.0, baseOpacity: 0.5, offsetOpacity: 0.03, title: "Heavy", yOffset: -80)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ToolbarHelpButton(showHelp: $showHelp)
            }
        }
        .onAppear {
            showHelp = !UserDefaults.standard.bool(forKey: "ButtonsView")
            withAnimation(.easeInOut(duration: 1)) {
                isStackVisible = true
            }
            if motionManager.isDeviceMotionAvailable {
                self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
                self.motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (data, error) in
                    if let validData = data {
                        self.motion = validData
                    }
                }
            }
            HapticManager.prepareHaptics()
        }
        .sheet(isPresented: $showHelp, content: {
            HelpView(helpText: "helpViewToggle", screenKey: "ButtonsView", isPresented: $showHelp)
        })
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
    }
}
