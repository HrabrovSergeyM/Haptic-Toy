//
//  ToggleView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

import SwiftUI

struct ToggleView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var showHelp: Bool = false
    @State private var isStackVisible: Bool = false
    
    var body: some View {
        ZStack {
            
            Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
            
            VStack(spacing: 20) {
                VStack(spacing: 20) {
                    Text("Soft")
                        .font(Font.system(size: 28, weight: .thin, design: .rounded))
                    
                    HStack(spacing: 20) {
                        ForEach(0..<5) { index in
                            Button(action: {
                                let intensityValue = Float(0.6)
                                let sharpnessValue = 1.0 - (Float(index) * 0.15)
                                HapticManager.playHapticWithIntensity(intensityValue, sharpness: sharpnessValue)
                            }) {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(
                                        colorScheme == .light ?
                                        Color("ColorGray").opacity(Double(index + 1) * 0.03 + 0.1)
                                        : Color("ColorGray").opacity(Double(1 - index) * 0.08 + 0.8)
                                    )
                                    .shadow(color: .primary.opacity(0.4), radius: 4, x: 0, y: 0)
                                    .frame(width: 50, height: 50)
                            }
                            
                        }
                    }
                }
                .opacity(isStackVisible ? 1 : 0)
                .offset(y: isStackVisible ? 0 : -40)
                
                VStack(spacing: 20) {
                    Text("Medium")
                        .font(Font.system(size: 28, weight: .medium, design: .rounded))
                    HStack(spacing: 20) {
                        ForEach(0..<5) { index in
                            Button(action: {
//                                let intensityValue = 0.6 + (Float(index) * 0.04)
//                                let sharpnessValue = 0.7 + (Float(index) * 0.04)
                                let intensityValue = Float(0.8)
                                let sharpnessValue = 1.0 - (Float(index) * 0.15)
                                HapticManager.playHapticWithIntensity(intensityValue, sharpness: sharpnessValue)
                            }) {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(
                                        colorScheme == .light ?
                                        Color("ColorGray").opacity(Double(index + 1) * 0.03 + 0.3)
                                        : Color("ColorGray").opacity(Double(1 - index) * 0.08 + 0.55)
                                    )
                                    .shadow(color: .primary.opacity(0.4), radius: 4, x: 0, y: 0)
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                }
                .opacity(isStackVisible ? 1 : 0)
                .offset(y: isStackVisible ? 0 : -60)
                
                VStack(spacing: 20) {
                    Text("Heavy")
                        .font(Font.system(size: 28, weight: .heavy, design: .rounded))
                    
                    HStack(spacing: 20) {
                        ForEach(0..<5) { index in
                            Button(action: {
                                //                                let intensityValue = 0.8 + (Float(index) * 0.06)
                                //                                let sharpnessValue = 0.9 + (Float(index) * 0.02)
                                let intensityValue = 1.0
                                let sharpnessValue = 1.0 - (Float(index) * 0.15)
                                HapticManager.playHapticWithIntensity(Float(intensityValue), sharpness: Float(sharpnessValue))
                            }) {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(
                                        colorScheme == .light ?
                                        Color("ColorGray").opacity(Double(index + 1) * 0.03 + 0.5)
                                        : Color("ColorGray").opacity(Double(1 - index) * 0.08 + 0.35)
                                    )
                                    .shadow(color: .primary.opacity(0.4), radius: 4, x: 0, y: 0)
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                    
                }
                .opacity(isStackVisible ? 1 : 0)
                .offset(y: isStackVisible ? 0 : -80)
//                Spacer()
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
            HelpView(helpText: NSLocalizedString("helpViewToggle", comment: ""), screenKey: "ToggleView", isPresented: $showHelp)
        })
        
    }
}

struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleView()
    }
}
