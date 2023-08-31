//
//  CGPoints.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 31.08.2023.
//

import SwiftUI

extension CGPoint {
    var asUnitPoint: UnitPoint {
        return UnitPoint(x: CGFloat(self.x), y: CGFloat(self.y))
    }
}
