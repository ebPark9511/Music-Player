//
//  MediaService.swift
//  MediaKit
//
//  Created by 박은비 on 3/20/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MediaPlayer
import MediaKitInterface
import Combine
import AVFoundation

final class MediaServiceImpl: MediaService {
    
    private let player: MPMusicPlayerController
    private let audioSession: AVAudioSession
    
    init(
        player: MPMusicPlayerController,
        audioSession: AVAudioSession
    ) {
        self.player = player
        self.audioSession = audioSession
        
        do {
            try audioSession.setCategory(.playback, options: .mixWithOthers)
            try audioSession.setActive(true)
        } catch {
            print("Failed to setup audio session:", error)
        }
    }
    
    
    func play(items: [SongEntity], isShuffle: Bool) -> [SongEntity] {
        let items: [SongEntity] = isShuffle ? items.shuffled() : items
        player.setQueue(with: items.map { $0.id })
        player.play()
        
        return items
    }
    
    func resume() {
        player.play()
    }
    
    func pause() {
        player.stop()
    }
    
    func setVolume(_ volume: Float) {
        MPVolumeView.setVolume(volume)
    }
    
    func observeVolume() -> AnyPublisher<Float, Never> {
        return Just(audioSession.outputVolume)
            .merge(with:
                    NotificationCenter.default.publisher(for: Notification.Name("SystemVolumeDidChange"))
                .compactMap { notification in
                    notification.userInfo?["Volume"] as? Float
                }
            )
            .eraseToAnyPublisher()
    }
    
    func observeNowPlaying() -> AnyPublisher<SongEntity?, Never> {
        Just(player.nowPlayingItem)
            .merge(with:
                    NotificationCenter.default.publisher(for: .MPMusicPlayerControllerNowPlayingItemDidChange, object: player)
                .map { notification in
                    (notification.object as? MPMusicPlayerController)?.nowPlayingItem
                }
            )
            .eraseToAnyPublisher()
    }
    
    func observePlaybackState() -> AnyPublisher<MPMusicPlaybackState?, Never> {
        Just(player.playbackState)
            .merge(with:
                    NotificationCenter.default.publisher(for: .MPMusicPlayerControllerPlaybackStateDidChange, object: player)
                .map { notification in
                    (notification.object as? MPMusicPlayerController)?.playbackState
                }
            )
            .eraseToAnyPublisher()
    }
    
}

private extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            slider?.value = volume
        }
    }
}
