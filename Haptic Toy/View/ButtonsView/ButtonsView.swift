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
    @ObservedObject var buttonsModelView: ButtonsModelView = ButtonsModelView()
    @State var showHelp: Bool = false
    @State var isStackVisible: Bool = false
    @State var motion: CMDeviceMotion? = nil
    @State var selectedColor: Color = Color("ColorGray")
    @State var gradientColors: [Color] = [.gray]
    @State var gradientAngle: GradientAngle = GradientAngle(startPoint: .top, endPoint: .bottom)
    @State var selectedSound: [String] = ["breakingBass0", "breakingBass1", "breakingBass2", "breakingBass3", "breakingBass4", "breakingBass5", "breakingBass6", "breakingBass7", "breakingBass8", "breakingBass9", "breakingBass10", "breakingBass11", "breakingBass12", "breakingBass13", "breakingBass14"]
    let motionManager = CMMotionManager()
    let value: String
    @ObservedObject var theme = ColorThemeChangerService.shared
    var themes: [ColorTheme] = themeData
    
    init(value: String) {
        self.value = value
        print("Init: \(value)")
    }
    
    var body: some View {
        ZStack {
//            Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
            themes[self.theme.themeSettings].themeSecondaryColor.opacity(0.7).ignoresSafeArea()
            
            buttonsSection
                
                .blur(radius: (buttonsModelView.isShowingPalette || buttonsModelView.isShowingSoundBar) ? 8.0 : 0, opaque: false)
                .animation(.default, value: buttonsModelView.isShowingPalette || buttonsModelView.isShowingSoundBar)
            
            if buttonsModelView.isShowingPalette || buttonsModelView.isShowingSoundBar {
                blankView
            }
            
            palette
            
            soundBar
            
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    buttonsModelView.isShowingSoundBar = true
                    HapticManager.notification(type: .success)
                } label: {
                    Image(systemName: "music.note.list")
                }
                .disabled(buttonsModelView.isShowingPalette)
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    buttonsModelView.isShowingPalette = true
                    HapticManager.notification(type: .success)
                } label: {
                    Image(systemName: "paintpalette")
                }
                .disabled(buttonsModelView.isShowingSoundBar)
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                ToolbarHelpButton(showHelp: $showHelp)
                    .disabled(buttonsModelView.isShowingSoundBar || buttonsModelView.isShowingPalette)
            }
        }
        .onAppear {
            showHelp = !UserDefaults.standard.bool(forKey: "ButtonsView")
            if let savedColors = UserDefaults.standard.colorsForKey(key: "gradientColors") {
                gradientColors = savedColors.map { Color($0) }
            }
            
            if let savedColor = UserDefaults.standard.colorForKey(key: "selectedColor") {
                selectedColor = Color(savedColor)
            }
            
            if let startPoint = UserDefaults.standard.gradientPoint(forKey: "gradientAngleStartPoint"),
               let endPoint = UserDefaults.standard.gradientPoint(forKey: "gradientAngleEndPoint") {
                gradientAngle = GradientAngle(startPoint: startPoint.asUnitPoint, endPoint: endPoint.asUnitPoint)
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
            ButtonsSection(isStackVisible: $isStackVisible, motion: $motion, motionManager: motionManager, intensity: 0.6, title: "Soft", yOffset: -40, brightness: colorScheme == .light ? 0.4 : -0.1, titleWeight: .thin, rowIndex: 0, selectedColor: selectedColor, gradientColors: gradientColors, selectedSound: selectedSound, gradientAngle: gradientAngle)
            ButtonsSection(isStackVisible: $isStackVisible, motion: $motion, motionManager: motionManager, intensity: 0.8, title: "Medium", yOffset: -60, brightness: colorScheme == .light ? 0.34 : -0.18, titleWeight: .light, rowIndex: 1, selectedColor: selectedColor, gradientColors: gradientColors, selectedSound: selectedSound, gradientAngle: gradientAngle)
            ButtonsSection(isStackVisible: $isStackVisible, motion: $motion, motionManager: motionManager, intensity: 1.0, title: "Heavy", yOffset: -80, brightness: colorScheme == .light ? 0.28 : -0.26, titleWeight: .regular, rowIndex: 2, selectedColor: selectedColor, gradientColors: gradientColors, selectedSound: selectedSound, gradientAngle: gradientAngle)
        }
        .foregroundColor(themes[self.theme.themeSettings].themeForegroundColor)
    }
    
    private var palette: some View {
        PaletteView(isShowingPalette: $buttonsModelView.isShowingPalette, selectedColor: $selectedColor, gradientColors: $gradientColors, gradientAngle: $gradientAngle)
            .frame(height: 500, alignment: .center)
            .accentColor(themes[self.theme.themeSettings].themeForegroundColor)
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding()
            .animation(.easeInOut, value: buttonsModelView.isShowingPalette)
            .offset(y: buttonsModelView.isShowingPalette ? 0 : UIScreen.main.bounds.height)
    }
    
    private var soundBar: some View {
        SoundBarView(isShowingSoundBar: $buttonsModelView.isShowingSoundBar, selectedSound: $selectedSound)
            .frame(width: 300, height: 240, alignment: .center)
            .accentColor(themes[self.theme.themeSettings].themeForegroundColor)
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding()
            .animation(.easeInOut, value: buttonsModelView.isShowingSoundBar)
            .offset(y: buttonsModelView.isShowingSoundBar ? 0 : UIScreen.main.bounds.height)
    }
    
    private var blankView: some View {
        BlankView(
            backgroundColor: isDarkMode ? .black : .gray,
            backgroundOpacity: isDarkMode ? 0.3 : 0.5
        )
        .onTapGesture {
            withAnimation {
                if !gradientColors.isEmpty {
                    buttonsModelView.isShowingPalette = false
                }
                buttonsModelView.isShowingSoundBar = false
            }
        }
    }
    
}
