//
//  UserDefaults.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.08.2023.
//

import Foundation
import SwiftUI

extension UserDefaults {
    static let selectedSoundNameKey = "selectedSoundName"
    
    static var selectedSoundName: String? {
        get {
            return UserDefaults.standard.string(forKey: selectedSoundNameKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: selectedSoundNameKey)
        }
    }
    
    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            do {
                colorData = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as NSData
            } catch {
                print("Failed to archive color data.")
            }
        }
        set(colorData, forKey: key)
    }
    
    func colorForKey(key: String) -> UIColor? {
        guard let colorData = data(forKey: key) else { return nil }
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)
        } catch {
            print("Failed to unarchive color data.")
            return nil
        }
    }
    
    func setColors(colors: [UIColor]?, forKey key: String) {
        guard let colors = colors else {
            removeObject(forKey: key)
            return
        }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: colors, requiringSecureCoding: false)
            set(data, forKey: key)
        } catch {
            print("Failed to archive colors.")
        }
    }
    
    func colorsForKey(key: String) -> [UIColor]? {
        guard let data = data(forKey: key) else { return nil }
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, UIColor.self], from: data) as? [UIColor]
        } catch {
            print("Failed to unarchive colors.")
            return nil
        }
    }
    
    func setAngle(point: CGPoint, forKey key: String) {
        let pointData = NSCoder.string(for: point)
        set(pointData, forKey: key)
    }
    
    func gradientPoint(forKey key: String) -> CGPoint? {
        guard let pointString = string(forKey: key) else { return nil }
        return NSCoder.cgPoint(for: pointString)
    }
}
