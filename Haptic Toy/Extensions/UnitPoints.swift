//
//  UnitPoints.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 31.08.2023.
//

import SwiftUI

extension UnitPoint {
    var asCGPoint: CGPoint {
        return CGPoint(x: Double(self.x), y: Double(self.y))
    }
}
