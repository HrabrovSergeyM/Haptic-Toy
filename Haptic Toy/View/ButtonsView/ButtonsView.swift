//
//  ToggleView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

import SwiftUI
import CoreMotion

struct ButtonsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var showHelp: Bool = false
    @State var isStackVisible: Bool = false
    @State var motion: CMDeviceMotion? = nil
    @State var showPalette: Bool = false
    @State var selectedColor: Color = Color("ColorGray")
    let motionManager = CMMotionManager()
    let value: String
    
    init(value: String) {
        self.value = value
        print("Init: \(value)")
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
            buttonsSection
                .sheet(isPresented: $showPalette, content: {
                        PaletteView(isShowingPalette: $showPalette, selectedColor: $selectedColor)
                    })

        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ToolbarHelpButton(showHelp: $showHelp)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showPalette = true
                } label: {
                    Image(systemName: "paintpalette")
                }

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
        ButtonsView(value: "ButtonsView")
    }
}

extension ButtonsView {
    
    private var buttonsSection: some View {
       
            VStack(spacing: 20) {
                ButtonsSection(isStackVisible: $isStackVisible, motion: $motion, motionManager: motionManager, intensity: 0.6, title: "Soft", yOffset: -40, brightness: colorScheme == .light ? 0.4 : -0.1, titleWeight: .thin, rowIndex: 0, selectedColor: selectedColor)
                ButtonsSection(isStackVisible: $isStackVisible, motion: $motion, motionManager: motionManager, intensity: 0.8, title: "Medium", yOffset: -60, brightness: colorScheme == .light ? 0.34 : -0.18, titleWeight: .light, rowIndex: 1, selectedColor: selectedColor)
                ButtonsSection(isStackVisible: $isStackVisible, motion: $motion, motionManager: motionManager, intensity: 1.0, title: "Heavy", yOffset: -80, brightness: colorScheme == .light ? 0.28 : -0.26, titleWeight: .regular, rowIndex: 2, selectedColor: selectedColor)
            }
        
        
    }
    
}
