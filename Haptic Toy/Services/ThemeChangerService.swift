//
//  ThemeChangerService.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 31.08.2023.
//

import SwiftUI

struct ThemeChangerController: UIViewControllerRepresentable {
    
    @Binding var isDarkMode: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: ThemeChangerController
        var previousMode: Bool?
        
        init(_ parent: ThemeChangerController) {
            self.parent = parent
            self.previousMode = parent.isDarkMode
        }
    }

    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        guard let window = UIApplication.shared.windows.first else { return }
        guard let window = UIApplication.firstKeyWindowForConnectedScenes?.rootViewController?.view else { return }
        
        if context.coordinator.previousMode != isDarkMode {
            if isDarkMode {
                UIView.transition(with: window, duration: 0.7, options: .transitionCrossDissolve, animations: {
                    window.overrideUserInterfaceStyle = .dark
                })
            } else {
                UIView.transition(with: window, duration: 0.7, options: .transitionCrossDissolve, animations: {
                    window.overrideUserInterfaceStyle = .light
                })
            }
            
            context.coordinator.previousMode = isDarkMode
        }
    }
}
