//
//  AudioPlayer.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//
// TODO: Refactoring

import Foundation
import AVFoundation

let audioPlayerPool = AudioPlayerPool()

var audioPlayer: AVAudioPlayer?
let fadeDuration: TimeInterval = 0.5
var fadeOutTimer: Timer?

func startRepeatingSound(sound: String, type: String) {
    resetAudio()

    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Could not find and play the sound file.")
        }
    }
}

func startSound(sound: String, type: String) {
    resetAudio()

    if let player = audioPlayerPool.playerForSound(sound: sound, type: type) {
        player.play()
    } else {
        print("Could not find and play the sound file.")
    }
}

func stopSound() {
    audioPlayer?.stop()
    audioPlayer = nil
}

func fadeOutSound() {
    fadeOutTimer?.invalidate()
    fadeOutTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
        if audioPlayer?.volume ?? 0 > 0.05 {
            audioPlayer?.volume -= 0.05
        } else {
            timer.invalidate()
            audioPlayer?.stop()
        }
    }
  
}
func resetAudio() {
    fadeOutTimer?.invalidate()
    fadeOutTimer = nil
    audioPlayer?.stop()
    audioPlayer = nil
}
