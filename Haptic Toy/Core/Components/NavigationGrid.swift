//
//  NavigationGrid.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 25.07.2023.
//

//TODO: Fixed this file

import SwiftUI

struct NavigationGrid: View {
    
    var destination: AnyView
    var image: String
    var text: String
    var isAnimated: Bool
    
    var body: some View {
        
        
        
        VStack {
            NavigationLink(destination: destination) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
            }
            Text(text)
                .font(Font.system(size: 24, weight: .thin, design: .rounded))
        }
        .opacity(isAnimated ? 1 : 0)
                   .offset(y: isAnimated ? 0 : -50)
                   .animation(.easeOut(duration: 1.5), value: isAnimated)
        
    }
}

