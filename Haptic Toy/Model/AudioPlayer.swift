//
//  AudioPlayer.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

import Foundation
import AVFoundation

final class AudioManager: NSObject {

    static let shared = AudioManager()
    private override init() {}

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
            cleanUpFinishedPlayers()
            let audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer.delegate = self
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
            cleanUpFinishedPlayers()
            let audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer.delegate = self
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
            let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(fadeOutStep), repeats: true) { [weak self] timer in
                guard let self = self else {
                    timer.invalidate()
                    return
                }
                if player.volume > fadeOutStep {
                    player.volume -= fadeOutStep
                } else {
                    timer.invalidate()
                    player.stop()
                    self.activeAudioPlayers.removeAll(where: { $0 == player })
                }
            }
            fadeOutTimers.append(timer)
        }
    }

    private func cleanUpFinishedPlayers() {
        activeAudioPlayers = activeAudioPlayers.filter { $0.isPlaying }
    }
}

extension AudioManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        activeAudioPlayers.removeAll(where: { $0 === player })
    }
}
