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
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6).ignoresSafeArea()
            VStack {
                
                HStack {
                    Text("Gradient line: ")
                        .font(Font.system(size: 24, weight: .thin, design: .rounded))
                    
                    Button {
                        HapticManager.impact(style: .light)
                        gradientAngle = GradientAngle(startPoint: .topLeading, endPoint: .bottomTrailing)
                        isSelected2 = false
                        isSelected3 = false
                        isSelected1 = true
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(5)
                            .shadow(color: .gray.opacity(0.15), radius: 3, x: 0, y: 0)
                            .frame(width: isSelected1 ? 40 : 30, height: isSelected1 ? 40 : 30)
                            .animation(.spring(), value: isSelected1)
                            .animation(.spring(), value: gradientColors)
                            .brightness(1.0 * 0.02 + (colorScheme == .light ? 0.28 : -0.26))
                    }
                    
                    Button {
                        HapticManager.impact(style: .light)
                        gradientAngle = GradientAngle(startPoint: .top, endPoint: .bottom)
                        
                        isSelected3 = false
                        isSelected1 = false
                        isSelected2 = true
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(5)
                            .shadow(color: .gray.opacity(0.15), radius: 3, x: 0, y: 0)
                            .frame(width: isSelected2 ? 40 : 30, height: isSelected2 ? 40 : 30)
                            .animation(.spring(), value: isSelected2)
                            .animation(.spring(), value: gradientColors)
                            .brightness(1.0 * 0.02 + (colorScheme == .light ? 0.28 : -0.26))
                    }
                    
                    Button {
                        HapticManager.impact(style: .light)
                        gradientAngle = GradientAngle(startPoint: .topTrailing, endPoint: .bottomLeading)
                        isSelected2 = false
                        
                        isSelected1 = false
                        isSelected3 = true
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topTrailing, endPoint: .bottomLeading))
                            
                            .cornerRadius(5)
                            .shadow(color: .gray.opacity(0.15), radius: 3, x: 0, y: 0)
                            .frame(width: isSelected3 ? 40 : 30, height: isSelected3 ? 40 : 30)
                            .animation(.spring(), value: isSelected3)
                            .animation(.spring(), value: gradientColors)
                            .brightness(1.0 * 0.02 + (colorScheme == .light ? 0.28 : -0.26))
                            
                            
                    }
                }
                HStack {
                    Text("Your button: ")
                        .font(Font.system(size: 24, weight: .thin, design: .rounded))
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: gradientAngle.startPoint, endPoint: gradientAngle.endPoint))
                        .cornerRadius(5)
                        .shadow(color: .gray.opacity(0.15), radius: 3, x: 0, y: 0)
                        .frame(width: 40, height: 40)
                        .brightness(1.0 * 0.02 + (colorScheme == .light ? 0.28 : -0.26))
                        .animation(.spring(), value: gradientColors)
                        .animation(.spring(), value: gradientAngle.endPoint)
                }
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
                    ForEach(colors, id: \.self) { color in
                        Button(action: {
                            HapticManager.impact(style: .light)
                            withAnimation(.easeIn) {
                                gradientColors.append(color)
                            }
                            self.selectedColor = color
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
                
                .padding(40)
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
                        withAnimation {
                            isShowingPalette = false
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
