//
//  GridElement.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 03.08.2023.
//

import Foundation
import SwiftUI

struct GridElementData: Identifiable {
    let id: UUID
    let destination: String
    let imageName: String
    let text: String
    let offset: Int
    let delayTime: Int
}
