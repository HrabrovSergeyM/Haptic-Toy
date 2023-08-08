//
//  CatShape.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 09.08.2023.
//

import SwiftUI

struct CatShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addEllipse(in: CGRect(x: rect.midX - 70, y: rect.midY - 200, width: 140, height: 100))
        
        path.addEllipse(in: CGRect(x: rect.midX - 70, y: rect.midY - 150, width: 140, height: 350))
        
        path.addEllipse(in: CGRect(x: rect.midX - 90, y: rect.midY + 30, width: 200, height: 170))
        path.addEllipse(in: CGRect(x: rect.midX - 10, y: rect.midY + 90, width: 120, height: 120))
        
        return path
    }
}

