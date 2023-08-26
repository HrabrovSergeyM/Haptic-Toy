//
//  PaletteView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.08.2023.
//

import SwiftUI

struct PaletteView: View {
    @Environment(\.colorScheme) var colorScheme
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
    @State var isSelected1: Bool = false
    @State var isSelected2: Bool = true
    @State var isSelected3: Bool = false
    @State var isSelected4: Bool = false
    @State var isSelected5: Bool = false
    @State var isSelected6: Bool = false
    @State private var showAlert: Bool = false
    @State private var isShowingColors = true
    
    
    
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
                            HStack(spacing: 15) {
                                Button {
                                    HapticManager.impact(style: .light)
                                    gradientAngle = GradientAngle(startPoint: .topLeading, endPoint: .bottomTrailing)
                                    isSelected1 = true
                                    isSelected2 = false
                                    isSelected3 = false
                                    isSelected4 = false
                                    isSelected5 = false
                                    isSelected6 = false
                                } label: {
                                    Rectangle()
                                        .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .cornerRadius(5)
                                        .shadow(color: .gray.opacity(0.15), radius: 3, x: 0, y: 0)
                                        .frame(width: isSelected1 ? 50 : 40, height: isSelected1 ? 50 : 40)
                                        .animation(.spring(), value: isSelected1)
                                        .brightness(1.0 * 0.02 + (colorScheme == .light ? 0.28 : -0.26))
                                }
                                
                                Button {
                                    HapticManager.impact(style: .light)
                                    gradientAngle = GradientAngle(startPoint: .top, endPoint: .bottom)
                                    isSelected1 = false
                                    isSelected2 = true
                                    isSelected3 = false
                                    isSelected4 = false
                                    isSelected5 = false
                                    isSelected6 = false
                                } label: {
                                    Rectangle()
                                        .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom))
                                        .cornerRadius(5)
                                        .shadow(color: .gray.opacity(0.15), radius: 3, x: 0, y: 0)
                                        .frame(width: isSelected2 ? 50 : 40, height: isSelected2 ? 50 : 40)
                                        .animation(.spring(), value: isSelected2)
                                        .animation(.spring(), value: gradientColors)
                                        .brightness(1.0 * 0.02 + (colorScheme == .light ? 0.28 : -0.26))
                                }
                                
                                Button {
                                    HapticManager.impact(style: .light)
                                    gradientAngle = GradientAngle(startPoint: .topTrailing, endPoint: .bottomLeading)
                                    isSelected1 = false
                                    isSelected2 = false
                                    isSelected3 = true
                                    isSelected4 = false
                                    isSelected5 = false
                                    isSelected6 = false
                                } label: {
                                    Rectangle()
                                        .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topTrailing, endPoint: .bottomLeading))
                                        .cornerRadius(5)
                                        .shadow(color: .gray.opacity(0.15), radius: 3, x: 0, y: 0)
                                        .frame(width: isSelected3 ? 50 : 40, height: isSelected3 ? 50 : 40)
                                        .animation(.spring(), value: isSelected3)
                                        .animation(.spring(), value: gradientColors)
                                        .brightness(1.0 * 0.02 + (colorScheme == .light ? 0.28 : -0.26))
                                }
                                Button {
                                    HapticManager.impact(style: .light)
                                    gradientAngle = GradientAngle(startPoint: .bottom, endPoint: .top)
                                    isSelected1 = false
                                    isSelected2 = false
                                    isSelected3 = false
                                    isSelected4 = true
                                    isSelected5 = false
                                    isSelected6 = false
                                } label: {
                                    Rectangle()
                                        .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .bottom, endPoint: .top))
                                        .cornerRadius(5)
                                        .shadow(color: .gray.opacity(0.15), radius: 3, x: 0, y: 0)
                                        .frame(width: isSelected4 ? 50 : 40, height: isSelected4 ? 50 : 40)
                                        .animation(.spring(), value: isSelected4)
                                        .animation(.spring(), value: gradientColors)
                                        .brightness(1.0 * 0.02 + (colorScheme == .light ? 0.28 : -0.26))
                                }
                                Button {
                                    HapticManager.impact(style: .light)
                                    gradientAngle = GradientAngle(startPoint: .bottomLeading, endPoint: .top)
                                    isSelected1 = false
                                    isSelected2 = false
                                    isSelected3 = false
                                    isSelected4 = false
                                    isSelected5 = true
                                    isSelected6 = false
                                } label: {
                                    Rectangle()
                                        .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .bottomLeading, endPoint: .top))
                                        .cornerRadius(5)
                                        .shadow(color: .gray.opacity(0.15), radius: 3, x: 0, y: 0)
                                        .frame(width: isSelected5 ? 50 : 40, height: isSelected5 ? 50 : 40)
                                        .animation(.spring(), value: isSelected5)
                                        .animation(.spring(), value: gradientColors)
                                        .brightness(1.0 * 0.02 + (colorScheme == .light ? 0.28 : -0.26))
                                }
                                Button {
                                    HapticManager.impact(style: .light)
                                    gradientAngle = GradientAngle(startPoint: .top, endPoint: .bottomTrailing)
                                    isSelected1 = false
                                    isSelected2 = false
                                    isSelected3 = false
                                    isSelected4 = false
                                    isSelected5 = false
                                    isSelected6 = true
                                } label: {
                                    Rectangle()
                                        .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottomTrailing))
                                        .cornerRadius(5)
                                        .shadow(color: .gray.opacity(0.15), radius: 3, x: 0, y: 0)
                                        .frame(width: isSelected6 ? 50 : 40, height: isSelected6 ? 50 : 40)
                                        .animation(.spring(), value: isSelected6)
                                        .animation(.spring(), value: gradientColors)
                                        .brightness(1.0 * 0.02 + (colorScheme == .light ? 0.28 : -0.26))
                                }
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
