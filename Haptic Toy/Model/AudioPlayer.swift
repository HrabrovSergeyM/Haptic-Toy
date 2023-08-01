//
//  AudioPlayer.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//
// TODO: Refactoring

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func startRepeatingSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.numberOfLoops = -1 // sound will be looped until 'stopSound()' is called
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Could not find and play the sound file.")
        }
    }
}

func startSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Could not find and play the sound file.")
        }
    }
}

func stopSound() {
    audioPlayer?.stop()
    audioPlayer = nil
}
