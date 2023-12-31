//
//  BubbleGameKitView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 09.08.2023.
//

import SwiftUI
import SpriteKit

struct BubbleGameKitView: UIViewRepresentable {
    var sceneSize: CGSize
    
    @Binding var displayMode: DisplayMode
    @Binding var restartKey: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator {
        var parent: BubbleGameKitView
        var lastDisplayMode: DisplayMode?
        
        init(_ parent: BubbleGameKitView) {
            self.parent = parent
        }
    }
    
    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        view.layer.borderWidth = .nan
        view.layer.borderColor = UIColor.clear.cgColor
        view.ignoresSiblingOrder = true
//        view.showsFPS = true
        return view
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        if restartKey {
            (uiView.scene as? BubblesScene)?.resetBubbles()
        }
        if let scene = uiView.scene as? BubblesScene {
            
            switch displayMode {
            case .standard:
                scene.rows = 15
                scene.maxColumns = 7
            case .extended:
                scene.rows = 21
                scene.maxColumns = 10
            case .maximum:
                scene.rows = 27
                scene.maxColumns = 13
            }
            
            if context.coordinator.lastDisplayMode != displayMode {
                scene.createBubbles()
            } else if !restartKey {
                scene.createBubbles()
            }
            
            scene.updateColorsForCurrentTheme(using: uiView.traitCollection)
            
            context.coordinator.lastDisplayMode = displayMode
            
        } else {
            let scene = BubblesScene(size: sceneSize, displayMode: displayMode)
            uiView.presentScene(scene)
            scene.updateColorsForCurrentTheme(using: uiView.traitCollection)
        }
    }
    
    
}
