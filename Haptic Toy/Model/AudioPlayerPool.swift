//
//  AudioPlayerPool.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 09.08.2023.
//
//TODO: FPS < 30 REFACTORING

import Foundation
import AVFoundation

class AudioPlayerPool {
    private var players: [AVAudioPlayer] = []
    private let maxPlayersCount = 25
    
    func playerForSound(sound: String, type: String) -> AVAudioPlayer? {
        if let availablePlayer = players.first(where: { !$0.isPlaying }) {
            return availablePlayer
        }
        
        if players.count < maxPlayersCount, let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                let player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                players.append(player)
                return player
            } catch {
                print("Could not create the audio player.")
                return nil
            }
        }
        
        return nil
    }
    
    func stopAllPlayers() {
        for player in players {
            player.stop()
        }
    }
}
