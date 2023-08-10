//
//  SpriteKitView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 09.08.2023.
//

import SwiftUI
import SpriteKit

struct SpriteKitView: UIViewRepresentable {
    var sceneSize: CGSize

    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        view.layer.borderWidth = .nan
        view.layer.borderColor = UIColor.clear.cgColor
//        view.isOpaque = true
        view.ignoresSiblingOrder = true
//        view.showsFPS = true
//        view.showsNodeCount = true
//        view.clipsToBounds = true
        return view
    }

    func updateUIView(_ uiView: SKView, context: Context) {
        if let scene = uiView.scene as? BubblesScene {
            scene.updateColorsForCurrentTheme(using: uiView.traitCollection)
        } else {
            let scene = BubblesScene(size: sceneSize)
//            scene.scaleMode = .resizeFill
            uiView.presentScene(scene)
            scene.updateColorsForCurrentTheme(using: uiView.traitCollection)
        }
    }
}
