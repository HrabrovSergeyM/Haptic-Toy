//
//  ColorThemePreview.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 01.09.2023.
//

import SwiftUI

struct ColorThemePreview: View {
    let lightImage: String
    let darkImage: String
    var body: some View {
    
            VStack {
                HStack {
                    VStack {
//                        Text("Light")
                        Image(lightImage)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .frame(height: 300)
                    }
                    VStack {
//                        Text("Dark")
                        Image(darkImage)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .frame(height: 300)
                    }
                }
   
            }
        }
        
        
        
    }


struct ColorThemePreview_Previews: PreviewProvider {
    static var previews: some View {
        ColorThemePreview(lightImage: "lightDefaultPreview", darkImage: "darkDefaultPreview")
    }
}
