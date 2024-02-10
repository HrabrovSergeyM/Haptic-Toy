//
//  AudioPlayer.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

import Foundation
import AVFoundation

class AudioManager {

    private var activeAudioPlayers: [AVAudioPlayer] = []
    private let fadeDuration: TimeInterval = 0.5
    private let fadeOutStep: Float = 0.05
    private var fadeOutTimers: [Timer] = []

    func startSound(sound: String, type: String) {
        guard let path = Bundle.main.path(forResource: sound, ofType: type) else {
            print("Couldn't find the sound file.")
            return
        }

        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            activeAudioPlayers.append(audioPlayer)
        } catch {
            print("Error playing the sound file: \(error.localizedDescription)")
        }
    }

    func startRepeatingSound(sound: String, type: String) {
        guard let path = Bundle.main.path(forResource: sound, ofType: type) else {
            print("Couldn't find the sound file.")
            return
        }

        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            activeAudioPlayers.append(audioPlayer)
        } catch {
            print("Error playing the sound file: \(error.localizedDescription)")
        }
    }

    func stopAllSounds() {
        for player in activeAudioPlayers {
            player.stop()
        }
        activeAudioPlayers.removeAll()
    }

    func fadeOutAllSounds() {
        for player in activeAudioPlayers {
            let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(fadeOutStep), repeats: true) { [self] timer in
                if player.volume > fadeOutStep {
                    player.volume -= fadeOutStep
                } else {
                    timer.invalidate()
                    player.stop()
                }
            }
            fadeOutTimers.append(timer)
        }
    }

    func cleanUpFinishedPlayers() {
        activeAudioPlayers = activeAudioPlayers.filter { $0.isPlaying }
    }
}
