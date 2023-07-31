//
//  BubbleMenuButtonView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 31.07.2023.
//

import SwiftUI

struct BubbleMenuButtonView: View {
    var body: some View {
        Menu {
            Button("Test") {
                //
            }
            Button("Test2") {
                //
            }
            Button("Test3") {
                //
            }
        } label: {
            Image(systemName: "gear")
                .resizable()
                .frame(width: 24, height: 24)
        }
        
        
        
    }
}

struct BubbleMenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleMenuButtonView()
    }
}
