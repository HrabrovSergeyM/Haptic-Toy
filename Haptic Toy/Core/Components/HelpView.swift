//
//  HelpView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 29.07.2023.
//

import SwiftUI

struct HelpView: View {
    var helpText: String
    @Binding var isPresented: Bool
    @State private var isTextVisible: Bool = false

    var body: some View {
        ZStack {
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Explore")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .padding(.bottom)
                Text(helpText)
                    .font(.title2)
                    .fontWeight(.thin)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                    .opacity(isTextVisible ? 1 : 0)
                    .offset(y: isTextVisible ? 0 : 50)  // add offset modifier
                Spacer()
                Button(action: {
                    isPresented = false
                }) {
                    Capsule()
                        .cornerRadius(0)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 75)
                        .overlay(alignment: .center, content: {
                            Text("Got it")
                                .multilineTextAlignment(.center)
                                .font(Font.system(size: 20, weight: .thin, design: .rounded))
                        })
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 4)
                        .foregroundColor(.primary)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .onAppear {
                withAnimation(.easeInOut(duration: 1)) {
                    isTextVisible = true
                }
            }
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView(helpText: "Welcome to a new world of tactile sensations. With the slider, you can control the intensity of vibration, feeling pleasant waves under your fingertips. Want to diversify your feelings? Press the button below and choose one of many vibration styles from the menu. Experiment and find your ideal style.", isPresented: .constant(true))
    }
}
