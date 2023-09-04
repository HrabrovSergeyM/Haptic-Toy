//
//  SwiftUIView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 04.08.2023.
//

import SwiftUI

struct LaunchView: View {
    
    // MARK: - Properties
    
    @State private var loadingText: [String] = "Haptic Toy".map {String($0)}
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    
    @State var isLabelVisible: Bool = false
    @State var isLogoVisible: Bool = false
    @Binding var showLaunchView: Bool
    
    private static let animationInterval: Double = 0.1
    private static let animationLoops: Int = 3
    private static let fontSize: CGFloat = 36
    private static let animationDuration: Double = 1
    
    @ObservedObject var theme = ColorThemeChangerService.shared
    var themes: [ColorTheme] = themeData
    
    private let timer = Timer.publish(every: animationInterval, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            themes[self.theme.themeSettings].themePrimaryColor.ignoresSafeArea()
            
            
            VStack {
                if isLabelVisible {
                    label
                }
                logo
            } // VStack
            .onAppear {
                withAnimation(.easeInOut(duration: 1)) {
                    isLabelVisible = true
                    isLogoVisible = true
                }
            }
        } // ZStack
        .onReceive(timer, perform: handleTimerTick)
    }
    
    // MARK: - Functions
    
    private func handleTimerTick(_: Date) {
        withAnimation(.spring()) {
            let lastIndex = loadingText.count - 1
            if counter == lastIndex {
                counter = 0
                loops += 1
                if loops >= LaunchView.animationLoops {
                    showLaunchView = false
                }
            } else {
                counter += 1
            }
        }
    }
    
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}

extension LaunchView {
    
    private var logo: some View {
        Image("logo")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(themes[self.theme.themeSettings].themeForegroundColor)
            .scaledToFit()
            .opacity(isLogoVisible ? 1 : 0)
            .animation(
                Animation
                    .easeInOut(duration: 4)
                    .repeatForever()
                , value: isLogoVisible
            )
    }
    
    private var label: some View {
        HStack(spacing: 0) {
            ForEach(Array(loadingText.indices), id: \.self) { index in
                Text(loadingText[index])
                    .font(Font.system(size: 36, weight: .thin, design: .rounded))
                    .opacity(isLabelVisible ? 1 : 0)
                    .offset(y: counter == index ? -5 : 0)
                    .foregroundColor(themes[self.theme.themeSettings].themeForegroundColor)
            }
            
        } // HStack
        .transition(AnyTransition.scale.animation(.easeIn))
    }
    
}
