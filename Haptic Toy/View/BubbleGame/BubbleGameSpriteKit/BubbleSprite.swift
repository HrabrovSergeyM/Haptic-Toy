//
//  BubbleSprite.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 09.08.2023.
//

import SwiftUI
import Foundation
import SpriteKit

class SpriteBubble: SKSpriteNode {
    var isPopped: Bool = false
    var prepopped: [String] = ["whiteSoftPrepopped", "whiteSoftPrepopped2", "whiteSoftPrepopped3", "whiteSoftPrepopped4"]
    var popped: [String] = ["whiteSoftPopped", "whiteSoftPopped2", "whiteSoftPopped3", "whiteSoftPopped4", "whiteSoftPopped5"]
    @ObservedObject var theme = ColorThemeChangerService.shared
    var themes: [ColorTheme] = themeData
    
    init() {
        let texture = SKTexture(imageNamed: prepopped.randomElement()!)
        super.init(texture: texture, color: .white, size: texture.size())
        self.name = "bubble"
        self.colorBlendFactor = 1.0
    }
    
    func pop() {
        guard !isPopped else { return }
        self.texture = SKTexture(imageNamed: popped.randomElement()!)
        isPopped = true
    }
    
    func updateColorForTheme(using traitCollection: UITraitCollection) {
        self.color = UIColor(themes[self.theme.themeSettings].themeForegroundColor).resolvedColor(with: traitCollection)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
