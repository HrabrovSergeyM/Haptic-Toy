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
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.tertiarySystemBackground
        
        let maxColumns = 8
        let rows = 15
        let totalWidth = size.width
        let totalHeight = size.height
        let bubbleWidth = totalWidth / CGFloat(maxColumns)
        let bubbleHeight = totalHeight / CGFloat(rows)
        
        for i in 0..<rows {
            let currentColumns = (i % 2 == 0) ? maxColumns - 1 : maxColumns
            let offset = (totalWidth - (CGFloat(currentColumns) * bubbleWidth)) / 2
            
            for j in 0..<currentColumns {
                let bubble = SpriteBubble()
                bubble.size = CGSize(width: bubbleWidth, height: bubbleHeight)
                bubble.position = CGPoint(x: offset + bubbleWidth * CGFloat(j) + bubbleWidth / 2,
                                          y: bubbleHeight * CGFloat(i) + bubbleHeight / 2)
                addChild(bubble)
            }
        }
        updateColorsForCurrentTheme(using: view.traitCollection)
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
            backgroundColor = UIColor.systemBackground
        }
        
        for node in self.children {
            if let bubble = node as? SpriteBubble {
                bubble.updateColorForTheme(using: traitCollection)
            }
        }
    }
}
