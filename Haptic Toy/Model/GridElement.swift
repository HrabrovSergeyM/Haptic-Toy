//
//  GridElement.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 03.08.2023.
//

import Foundation
import SwiftUI

struct GridElement: Identifiable {
    let id: UUID
    let destination: AnyView
    let imageName: String
    let text: String
    let isAnimated: Bool
    let offset: Int
    let delayTime: Int
}
