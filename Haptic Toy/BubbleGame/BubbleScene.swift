//
//  GameScene.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 09.08.2023.
//

import SpriteKit
import SwiftUI
import Swift

class BubblesScene: SKScene {
    var maxColumns: Int = 15
    var rows: Int = 7
    init(size: CGSize, displayMode: DisplayMode) {
        super.init(size: size)
        
        switch displayMode {
        case .standard:
            self.rows = 15
            self.maxColumns = 7
        case .extended:
            self.rows = 21
            self.maxColumns = 10
        case .maximum:
            self.rows = 26
            self.maxColumns = 13
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  
    
    override func didMove(to view: SKView) {
        createBubbles()
        updateColorsForCurrentTheme(using: view.traitCollection)
    }
    
    func createBubbles() {
        removeAllChildren()
        
        let padding: CGFloat = 10
        let totalWidth = size.width - 2 * padding
        let totalHeight = size.height - 2 * padding

        let bubbleWidth = totalWidth / CGFloat(maxColumns)
        let bubbleHeight = totalHeight / CGFloat(rows)
        
        for i in 0..<rows {
            let currentColumns = (i % 2 == 0) ? maxColumns - 1 : maxColumns
            let offset = (totalWidth - (CGFloat(currentColumns) * bubbleWidth)) / 2 + padding
            
            for j in 0..<currentColumns {
                let bubble = SpriteBubble()
                bubble.size = CGSize(width: bubbleWidth, height: bubbleHeight)
                bubble.position = CGPoint(
                    x: offset + bubbleWidth * CGFloat(j) + bubbleWidth / 2,
                    y: padding + bubbleHeight * CGFloat(i) + bubbleHeight / 2
                )
                addChild(bubble)
            }
        }
    }
    
    func resetBubbles() {
        for node in self.children {
            if let bubble = node as? SpriteBubble {
                bubble.isPopped = false
                bubble.texture = SKTexture(imageNamed: bubble.prepopped.randomElement()!)
            }
        }
    }
    
    override func willMove(from view: SKView) {
        audioPlayerPool.stopAllPlayers()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }
    
    private func handleTouches(_ touches: Set<UITouch>) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodesAtPoint = nodes(at: location)
            
            for node in nodesAtPoint {
                if let bubble = node as? SpriteBubble, !bubble.isPopped {
//                    startSound(sound: "pop", type: "mp3")
                    HapticManager.impact(style: .heavy)
                    
                    bubble.pop()
                }
            }
        }
    }
    
    func updateColorsForCurrentTheme(using traitCollection: UITraitCollection) {
        if traitCollection.userInterfaceStyle == .dark {
            backgroundColor = UIColor.tertiarySystemBackground
        } else {
            backgroundColor = UIColor.white
        }
        
        for node in self.children {
            if let bubble = node as? SpriteBubble {
                bubble.updateColorForTheme(using: traitCollection)
            }
        }
    }
}
