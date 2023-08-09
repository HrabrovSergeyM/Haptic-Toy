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
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Could not find and play the sound file.")
        }
    }
   
}

let audioPlayerPool = AudioPlayerPool()

func startSound(sound: String, type: String) {
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
