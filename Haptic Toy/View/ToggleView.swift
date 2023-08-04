//
//  ToggleView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

import SwiftUI

struct ToggleView: View {
    
    @State var showHelp: Bool = false
    
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
                                let intensityValue = 0.4 + (Float(index) * 0.04)
                                let sharpnessValue = 0.5 + (Float(index) * 0.04)
                                HapticManager.playHapticWithIntensity(intensityValue, sharpness: sharpnessValue)
                            }) {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color("ColorGray").opacity(Double(index + 1) * 0.03 + 0.1))
                                    .shadow(color: .primary.opacity(0.4), radius: 4, x: 0, y: 0)
                                    .frame(width: 50, height: 50)
                            }
                            
                        }
                    }
                }
                
                VStack(spacing: 20) {
                    Text("Medium")
                        .font(Font.system(size: 28, weight: .medium, design: .rounded))
                    HStack(spacing: 20) {
                        ForEach(0..<5) { index in
                            Button(action: {
                                let intensityValue = 0.6 + (Float(index) * 0.04)
                                let sharpnessValue = 0.7 + (Float(index) * 0.04)
                                HapticManager.playHapticWithIntensity(intensityValue, sharpness: sharpnessValue)
                            }) {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color("ColorGray").opacity(Double(index + 1) * 0.03 + 0.3))
                                    .shadow(color: .primary.opacity(0.4), radius: 4, x: 0, y: 0)
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                }
                
                VStack(spacing: 20) {
                    Text("Heavy")
                        .font(Font.system(size: 28, weight: .heavy, design: .rounded))
                    
                    HStack(spacing: 20) {
                        ForEach(0..<5) { index in
                            Button(action: {
                                let intensityValue = 0.8 + (Float(index) * 0.06)
                                let sharpnessValue = 0.9 + (Float(index) * 0.02)
                                HapticManager.playHapticWithIntensity(intensityValue, sharpness: sharpnessValue)
                            }) {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color("ColorGray").opacity(Double(index + 1) * 0.03 + 0.6))
//                                    .fill(Color("ColorGray"))
                                    .shadow(color: .primary.opacity(0.4), radius: 4, x: 0, y: 0)
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            showHelp = !UserDefaults.standard.bool(forKey: "ToggleView")
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
