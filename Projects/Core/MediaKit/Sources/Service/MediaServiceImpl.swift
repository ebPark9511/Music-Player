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
    
    private var cancellables: Set<AnyCancellable> = []
    private var observation: NSKeyValueObservation?
    
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
    
    func observeNowPlaying() -> AnyPublisher<SongEntity?, Never> {
        NotificationCenter.default.publisher(for: .MPMusicPlayerControllerNowPlayingItemDidChange, object: player)
            .map { notification in
                (notification.object as? MPMusicPlayerController)?.nowPlayingItem
            }
            .print("오왕굿~~")
            .eraseToAnyPublisher()
    }
    
}
