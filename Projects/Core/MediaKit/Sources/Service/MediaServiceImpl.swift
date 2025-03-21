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

final class MediaServiceImpl: MediaService {

    private let player: MPMusicPlayerController
    
    init(
        player: MPMusicPlayerController
    ) {
        self.player = player
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
    
    func previous() {
        guard player.indexOfNowPlayingItem > 0 else {
            restartCurrentSong()
            return
        }
        
        player.pause()
        player.skipToPreviousItem()
        player.prepareToPlay()
        player.play()
    }
    
    func next() {
        player.skipToNextItem()
    }
    
    func setRepeat(isOn: Bool) {
        if isOn {
            player.repeatMode = .one
        } else {
            player.repeatMode = .none
        }
    }
    
    func setVolume(_ volume: Float) {
        MPVolumeView.setVolume(volume)
    }
    
    func restartCurrentSong() {
        player.skipToBeginning()
        player.play()
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
