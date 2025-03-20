//
//  ObserveCurrentSongUseCaseImpl.swift
//  PlayerDomain
//
//  Created by 박은비 on 3/19/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import PlayerDomainInterface
import MediaKitInterface
import Combine

final class ObserveCurrentSongUseCaseImpl: ObserveCurrentSongUseCase {
    
    private let playerRepository: PlayerRepository
    
    init(
        playerRepository: PlayerRepository
    ) {
        self.playerRepository = playerRepository
    }
    
    func execute() -> AnyPublisher<Playable?, Never> {
        playerRepository.observeNowPlaying()
            
    }
}
