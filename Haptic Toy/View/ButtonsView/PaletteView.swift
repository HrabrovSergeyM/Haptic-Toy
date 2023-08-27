//
//  PaletteView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.08.2023.
//

import SwiftUI

struct PaletteView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var buttonsModelView: ButtonsModelView = ButtonsModelView()
    @Binding var isShowingPalette: Bool
    @Binding var selectedColor: Color
    var language = LocalizationService.shared.language
    let colors: [Color] = [
        .purple, .red, .teal,
        .yellow, .gray, .green,
        .blue, .indigo, .mint,
        .orange, .cyan, .pink
    ]
    @Binding var gradientColors: [Color]
    @Binding var gradientAngle: GradientAngle
    @State private var showAlert: Bool = false
    @State private var isShowingColors = true
    @State private var selectedButtonIndex: Int?
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6).ignoresSafeArea()
            
            VStack {
                HStack {
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: gradientAngle.startPoint, endPoint: gradientAngle.endPoint))
                        .border(!gradientColors.isEmpty ? .clear : .primary)
                        .cornerRadius(5)
                        .shadow(color: .gray.opacity(0.15), radius: 3, x: 0, y: 0)
                        .frame(width: 160, height: 160)
                        .brightness(1.0 * 0.02 + (colorScheme == .light ? 0.28 : -0.26))
                        .animation(.spring(), value: gradientColors)
                        .animation(.spring(), value: gradientAngle.endPoint)
                }
                
                Group {
                    if isShowingColors {
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack(spacing: 15) {
                                ForEach(colors, id: \.self) { color in
                                    Button(action: {
                                        HapticManager.impact(style: .light)
                                        gradientColors.append(color)
                                        self.selectedColor = color
//                                        let uiColors = gradientColors.map { UIColor($0) }
//                                        UserDefaults.standard.setColors(colors: uiColors, forKey: "gradientColors")
//
//                                        UserDefaults.standard.setColor(color: UIColor(color), forKey: "selectedColor")
                                    }) {
                                        Rectangle()
                                            .fill(color)
                                            .frame(width: 50, height: 50)
                                            .cornerRadius(5)
                                            .shadow(color: color.opacity(0.5), radius: 3, x: 2, y: 3)
                                            
                                    }
                                }
                            }
                            .frame(height: 75)
                        }
                        .padding(.horizontal, 40)
                        .padding(.vertical, 20)
                        
                    }
                }
                .transition(.slide)
                .opacity(isShowingColors ? 1 : 0)
                
                Group {
                    if !isShowingColors {
                        ScrollView(.horizontal, showsIndicators: false) {
                               HStack {
                                   ForEach(buttonsModelView.gradientAngles.indices, id: \.self) { index in
                                       GradientButton(
                                           gradientColors: gradientColors,
                                           gradientAngle: buttonsModelView.gradientAngles[index],
                                           colorScheme: colorScheme,
                                           isSelected: index == selectedButtonIndex,
                                           action: {
                                               HapticManager.impact(style: .light)
                                               selectedButtonIndex = index
                                               gradientAngle = buttonsModelView.gradientAngles[index]
                                           }
                                       )
                                   }
                               }
                               .onAppear {
                                   selectedButtonIndex = 1
                               }
                               .frame(height: 75)
                           }
                        .padding(.horizontal, 40)
                        .padding(.vertical, 20)
                    }
                }
                .transition(.slide)
                .opacity(isShowingColors ? 0 : 1)
                
                HStack {
                    Button(action: {
                        HapticManager.impact(style: .soft)
                        withAnimation {
                            isShowingColors = true
                        }
                    }) {
                        Text("colours".localized(language))
                            .padding()
                            .foregroundColor(isShowingColors ? .white : .primary)
                            .background(isShowingColors ? .blue : Color.clear)
                            .cornerRadius(15)
                    }
                    if gradientColors.count > 1 {
                        Button(action: {
                            HapticManager.impact(style: .soft)
                            withAnimation {
                                isShowingColors = false
                            }
                        }) {
                            Text("gradient".localized(language))
                                .padding()
                                .foregroundColor(!isShowingColors ? .white : .primary)
                                .background(!isShowingColors ? .blue : Color.clear)
                                .cornerRadius(15)
                        }
                    }
                }
                .font(Font.system(size: 18, weight: .thin, design: .rounded))
                .padding(.bottom, 20)
                .animation(.spring(), value: gradientColors)
                
                HStack {
                    Button(action: {
                        HapticManager.impact(style: .light)
                        withAnimation {
                            gradientColors = []
                            isShowingColors = true
                        }
                    }) {
                        Capsule()
                            .cornerRadius(0)
                            .foregroundColor(colorScheme == .dark ? Color(UIColor.tertiarySystemBackground) : .white)
                            .frame(width: 120, height: 50)
                            .overlay(alignment: .center, content: {
                                Text("reset".localized(language))
                                    .multilineTextAlignment(.center)
                                    .font(Font.system(size: 20, weight: .thin, design: .rounded))
                            })
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 4)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    Button {
                        HapticManager.impact(style: .light)
                            withAnimation {
                                isShowingPalette = false
                            }
                    } label: {
                        Capsule()
                            .cornerRadius(0)
                            .foregroundColor(colorScheme == .dark ? Color(UIColor.tertiarySystemBackground) : .white)
                            .frame(width: 120, height: 50)
                            .overlay(alignment: .center, content: {
                                Text("accept".localized(language))
                                    .multilineTextAlignment(.center)
                                    .font(Font.system(size: 20, weight: .thin, design: .rounded))
                                    
                            })
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 4)
                            .foregroundColor(.primary)
                            .opacity(gradientColors.isEmpty ? 0.2 : 1)
                    }
                    .disabled(gradientColors.isEmpty)
                }
                .padding(.horizontal, 40)
                
            }
        }
    }
}

struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteView(isShowingPalette: .constant(true), selectedColor: .constant(.gray), gradientColors: .constant([.red, .blue]), gradientAngle: .constant(GradientAngle(startPoint: .top, endPoint: .bottom)))
    }
}
