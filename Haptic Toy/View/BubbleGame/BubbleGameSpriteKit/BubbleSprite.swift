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
    private static let prepoppedNames = ["whiteSoftPrepopped", "whiteSoftPrepopped2", "whiteSoftPrepopped3", "whiteSoftPrepopped4"]
    private static let poppedNames = ["whiteSoftPopped", "whiteSoftPopped2", "whiteSoftPopped3", "whiteSoftPopped4", "whiteSoftPopped5"]
    
    private(set) var isPopped: Bool = false
    @ObservedObject var theme = ColorThemeChangerService.shared
    var themes: [ColorTheme] = themeData
    
    init() {
        let texture = SKTexture(imageNamed: SpriteBubble.randomImage(from: SpriteBubble.prepoppedNames))
        super.init(texture: texture, color: .white, size: texture.size())
        self.name = "bubble"
        self.colorBlendFactor = 1.0
    }
    
    func pop() -> Bool {
        guard !isPopped else { return false }
        self.texture = SKTexture(imageNamed: SpriteBubble.randomImage(from: SpriteBubble.poppedNames))
        isPopped = true
        return true
    }
    
    func reset() {
        isPopped = false
        texture = SKTexture(imageNamed: SpriteBubble.randomImage(from: SpriteBubble.prepoppedNames))
    }
    
    func updateColorForTheme(using traitCollection: UITraitCollection) {
        self.color = UIColor(themes[self.theme.themeSettings].themeForegroundColor).resolvedColor(with: traitCollection)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static func randomImage(from names: [String]) -> String {
        names.randomElement() ?? names.first ?? ""
    }
}
