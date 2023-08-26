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
        .purple, .red, .pink,
        .yellow, .mint, .green,
        .blue, .indigo, .gray,
        .orange, .cyan, .teal
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
                                        let uiColors = gradientColors.map { UIColor($0) }
                                        UserDefaults.standard.setColors(colors: uiColors, forKey: "gradientColors")
                                        
                                        UserDefaults.standard.setColor(color: UIColor(color), forKey: "selectedColor")
                                    }) {
                                        Rectangle()
                                            .fill(color)
                                            .cornerRadius(5)
                                            .shadow(color: color.opacity(0.15), radius: 3, x: 0, y: 0)
                                            .frame(width: 50, height: 50)
                                    }
                                }
                            }
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
                           }
                        .padding(.horizontal, 40)
                        .padding(.vertical, 20)
                    }
                }
                .transition(.slide)
                .opacity(isShowingColors ? 0 : 1)
                
                HStack {
                    Button(action: {
                        withAnimation {
                            isShowingColors = true
                        }
                    }) {
                        Text("Colours")
                            .padding()
                            .foregroundColor(isShowingColors ? .white : .primary)
                            .background(isShowingColors ? .blue : Color.clear)
                            .cornerRadius(15)
                    }
                    Button(action: {
                        withAnimation {
                            isShowingColors = false
                        }
                    }) {
                        Text("Gradient")
                            .padding()
                            .foregroundColor(!isShowingColors ? .white : .primary)
                            .background(!isShowingColors ? .blue : Color.clear)
                            .cornerRadius(15)
                    }
                }
                .font(Font.system(size: 18, weight: .thin, design: .rounded))
                .padding(.bottom, 20)
                
                HStack {
                    Button(action: {
                        HapticManager.impact(style: .light)
                        gradientColors = []
                    }) {
                        Capsule()
                            .cornerRadius(0)
                            .foregroundColor(colorScheme == .dark ? Color(UIColor.tertiarySystemBackground) : .white)
                            .frame(width: 100, height: 50)
                            .overlay(alignment: .center, content: {
                                Text("Reset")
                                    .multilineTextAlignment(.center)
                                    .font(Font.system(size: 20, weight: .thin, design: .rounded))
                            })
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 4)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    Button {
                        HapticManager.impact(style: .light)
                        if gradientColors.isEmpty {
                            showAlert = true
                        } else {
                            withAnimation {
                                isShowingPalette = false
                            }
                        }
                    } label: {
                        Capsule()
                            .cornerRadius(0)
                            .foregroundColor(colorScheme == .dark ? Color(UIColor.tertiarySystemBackground) : .white)
                            .frame(width: 100, height: 50)
                            .overlay(alignment: .center, content: {
                                Text("Accept")
                                    .multilineTextAlignment(.center)
                                    .font(Font.system(size: 20, weight: .thin, design: .rounded))
                            })
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 4)
                            .foregroundColor(.primary)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("No Colours"),
                              message: Text("Please, select one or more colours"),
                              dismissButton: .default(Text("Ok")))
                    }
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
