//
//  PlayerRepositoryImpl.swift
//  PlayerDomain
//
//  Created by 박은비 on 3/20/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MediaKitInterface
import PlayerDomainInterface
import Combine

final class PlayerRepositoryImpl: PlayerRepository {
    
    private let mediaService: MediaService
    private let _playlist = CurrentValueSubject<[SongEntity], Never>([])

    init(
        mediaService: MediaService
    ) {
        self.mediaService = mediaService
    }
    
    func play(items: [SongEntity], isShuffle: Bool) {
        let items = mediaService.play(items: items, isShuffle: isShuffle)
        _playlist.send(items)
    }
    
    func observePlayingList() -> AnyPublisher<[SongEntity], Never> {
        _playlist.eraseToAnyPublisher()
    }
    
    func observeNowPlaying() -> AnyPublisher<SongEntity?, Never> {
        mediaService.observeNowPlaying()
            
    }

}

