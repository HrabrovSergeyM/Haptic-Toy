//
//  HelpView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 29.07.2023.
//

import SwiftUI

struct HelpView: View {
    
    var helpText: String
    var screenKey: String
    var language = LocalizationService.shared.language
    var buttons: [HelpButton] = []
    
    @Binding var isPresented: Bool
    
    @State private var isTextVisible: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    
    init(helpText: String, screenKey: String, isPresented: Binding<Bool>, buttons: [HelpButton] = []) {
        self.helpText = helpText
        self.screenKey = screenKey
        self._isPresented = isPresented
        self.buttons = buttons
    }
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("helpViewTitle".localized(language))
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .padding(.bottom)
                Text(helpText.localized(language))
                    .font(.title2)
                    .fontWeight(.thin)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                    .opacity(isTextVisible ? 1 : 0)
                    .offset(y: isTextVisible ? 0 : 50)
                
                if !buttons.isEmpty {
                    VStack(alignment: .leading) {
                        ForEach(buttons) { button in
                            HStack {
                                Image(systemName: button.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(.trailing, 8)
                                Text(button.description.localized(language))
                                    .font(.title2)
                                    .fontWeight(.thin)
                            }
                            .padding(.bottom)
                            .opacity(isTextVisible ? 1 : 0)
                            .offset(y: isTextVisible ? 0 : 70)
                        }
                    }
                }

                Spacer()
                Button(action: {
                    isPresented = false
                    UserDefaults.standard.set(true, forKey: screenKey)
                    HapticManager.impact(style: .soft)
                }) {
                    Capsule()
                        .cornerRadius(0)
                        .foregroundColor(colorScheme == .dark ? Color(UIColor.tertiarySystemBackground) : .white)
                        .frame(width: 200, height: 75)
                        .overlay(alignment: .center, content: {
                            Text("helpViewButton".localized(language))
                                .multilineTextAlignment(.center)
                                .font(Font.system(size: 20, weight: .thin, design: .rounded))
                        })
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 4)
                        .foregroundColor(.primary)
                }
            } // VStack
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .onAppear {
                withAnimation(.easeInOut(duration: 1)) {
                    isTextVisible = true
                }
            }
        } // ZStack
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView(helpText: "Just pop it.", screenKey: "AnyView", isPresented: .constant(true), buttons: [
            HelpButton(imageName: "hand.draw", description: "helpViewDrawButton"),
            HelpButton(imageName: "arrow.triangle.2.circlepath", description: "helpViewRestartButton"),
            HelpButton(imageName: "rectangle.split.2x2.fill", description: "helpViewDisplayButton")
         ])
    }
}
