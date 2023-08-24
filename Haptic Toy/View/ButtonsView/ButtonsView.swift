//
//  ToggleView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

import SwiftUI
import CoreMotion

struct ButtonsView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @State var showHelp: Bool = false
    @State var isStackVisible: Bool = false
    @State var motion: CMDeviceMotion? = nil
    @State var showPalette: Bool = false
    @State var selectedColor: Color = Color("ColorGray")
    @State var showSoundBar: Bool = false
    @State var selectedSound: [String] = ["breakingBass0", "breakingBass1", "breakingBass2", "breakingBass3", "breakingBass4", "breakingBass5", "breakingBass6", "breakingBass7", "breakingBass8", "breakingBass9", "breakingBass10", "breakingBass11", "breakingBass12", "breakingBass13", "breakingBass14"]
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
                .blur(radius: (showPalette || showSoundBar) ? 8.0 : 0, opaque: false)
                .animation(.default, value: showPalette || showSoundBar)
             
            
            if showPalette || showSoundBar {
                blankView
            }
            
            palette
            
            soundBar
          
            
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showSoundBar = true
                } label: {
                    Image(systemName: "music.note.list")
                }
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showPalette = true
                } label: {
                    Image(systemName: "paintpalette")
                }
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                ToolbarHelpButton(showHelp: $showHelp)
            }
        }
        .onAppear {
            showHelp = !UserDefaults.standard.bool(forKey: "ButtonsView")
            
            if let savedUIColor = UserDefaults.standard.colorForKey(key: "selectedColor") {
                selectedColor = Color(savedUIColor)
            }
            
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
            ButtonsSection(isStackVisible: $isStackVisible, motion: $motion, motionManager: motionManager, intensity: 0.6, title: "Soft", yOffset: -40, brightness: colorScheme == .light ? 0.4 : -0.1, titleWeight: .thin, rowIndex: 0, selectedColor: selectedColor, selectedSound: selectedSound)
            ButtonsSection(isStackVisible: $isStackVisible, motion: $motion, motionManager: motionManager, intensity: 0.8, title: "Medium", yOffset: -60, brightness: colorScheme == .light ? 0.34 : -0.18, titleWeight: .light, rowIndex: 1, selectedColor: selectedColor, selectedSound: selectedSound)
            ButtonsSection(isStackVisible: $isStackVisible, motion: $motion, motionManager: motionManager, intensity: 1.0, title: "Heavy", yOffset: -80, brightness: colorScheme == .light ? 0.28 : -0.26, titleWeight: .regular, rowIndex: 2, selectedColor: selectedColor, selectedSound: selectedSound)
        }
        
        
    }
    
    private var palette: some View {
        PaletteView(isShowingPalette: $showPalette, selectedColor: $selectedColor)
            .frame(width: 300, height: 350, alignment: .center)
            .accentColor(.primary)
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding()
            .animation(.easeInOut, value: showPalette)
            .offset(y: showPalette ? 0 : UIScreen.main.bounds.height)
    }
    
    private var soundBar: some View {
        SoundBarView(isShowingSoundBar: $showSoundBar, selectedSound: $selectedSound)
            .frame(width: 300, height: 240, alignment: .center)
            .accentColor(.primary)
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding()
            .animation(.easeInOut, value: showSoundBar)
            .offset(y: showSoundBar ? 0 : UIScreen.main.bounds.height)
    }
    
    private var blankView: some View {
        BlankView(
            backgroundColor: isDarkMode ? .black : .gray,
            backgroundOpacity: isDarkMode ? 0.3 : 0.5
        )
        .onTapGesture {
            withAnimation {
                showPalette = false
                showSoundBar = false
            }
        }
    }
    
}
