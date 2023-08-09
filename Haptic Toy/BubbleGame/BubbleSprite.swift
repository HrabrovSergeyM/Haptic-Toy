//
//  BubbleSprite.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 09.08.2023.
//

import Foundation
import SpriteKit

class SpriteBubble: SKSpriteNode {
    var isPopped: Bool = false
    var prepopped: [String] = ["softPrepopped", "softPrepopped2", "softPrepopped3", "softPrepopped4"]
    var popped: [String] = ["softPopped", "softPopped2", "softPopped3", "softPopped4", "softPopped5"]
    init() {
        let texture = SKTexture(imageNamed: prepopped.randomElement()!)
        super.init(texture: texture, color: .clear, size: texture.size())
        self.name = "bubble"
        self.colorBlendFactor = 1.0
    }
    func pop() {
        guard !isPopped else { return } // Проверяем, что пузырь не взорван
        self.texture = SKTexture(imageNamed: popped.randomElement()!)
        isPopped = true
    }
    func updateColorForTheme(using traitCollection: UITraitCollection) {
        self.colorBlendFactor = 1.0
        self.color = traitCollection.userInterfaceStyle == .dark ? .white : .black
    }
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
