//
//  GridElement.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 03.08.2023.
//

import Foundation
import SwiftUI

//struct GridElementData: Identifiable {
//    let id: UUID
//    let destination: String
//    let imageName: String
//    let text: String
//    let offset: Int
//    let delayTime: Int
//}
struct GridElementData {
    let id: UUID
    let destination: GridDestination
    let baseImageName: GridBaseImageName
    let text: GridText
    let offset: CGFloat
    let delayTime: Int
}

enum GridDestination: String {
    case bubbleGameScreen = "BubbleGameScreen"
    case catView = "CatView"
    case buttonsView = "ButtonsView"
    case slidersView = "SlidersView"
    case numberPickerView = "NumberPickerView"
}

enum GridBaseImageName: String {
    case bubbleWrapper = "bubbleWrapper"
    case catNavigation = "catNavigation"
    case toggles = "toggles"
    case slider = "slider"
    case numberPicker = "numberPicker"
}

enum GridText: String {
    case bubbleWrapper = "bubbleWrapper"
    case purr = "purr"
    case buttonsAndToggles = "buttonsAndToggles"
    case slider = "slider"
    case rollerPicker = "rollerPicker"
}
