//
//  ColorThemePreview.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 01.09.2023.
//

import SwiftUI

struct ColorThemePreview: View {
    let image: String
    
    var body: some View {
    
            VStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .frame(height: 300)
   
            }
        }
        
        
        
    }


struct ColorThemePreview_Previews: PreviewProvider {
    static var previews: some View {
        ColorThemePreview(image: "lightDefaultPreview")
    }
}
