//
//  ObservePlaybackStateUseCaseImpl.swift
//  PlayerDomainInterface
//
//  Created by 박은비 on 3/20/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import PlayerDomainInterface
import MediaKitInterface
import Combine
import MediaPlayer

final class ObservePlaybackStateUseCaseImpl: ObservePlaybackStateUseCase {
   
    private let mediaService: MediaService
    
    init(
        mediaService: MediaService
    ) {
        self.mediaService = mediaService
    }
    
    func execute() -> AnyPublisher<PlayerState, Never> {
        mediaService.observePlaybackState()
            .compactMap { $0?.asPlayerState }
            .eraseToAnyPublisher()
    }
}

private extension MPMusicPlaybackState {
    var asPlayerState: PlayerState? {
        PlayerState(rawValue: self.rawValue)
    }
}
