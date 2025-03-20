//
//  ObservePlaybackTimeUseCaseImpl.swift
//  PlayerDomainInterface
//
//  Created by 박은비 on 3/21/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import Combine
import PlayerDomainInterface
import MediaKitInterface

final class ObservePlaybackTimeUseCaseImpl: ObservePlaybackTimeUseCase {
    
    private let playerRepository: PlayerRepository
    
    deinit {
        print("deinit ObservePlaybackTimeUseCaseImpl")
    }
    
    init(playerRepository: PlayerRepository) {
        self.playerRepository = playerRepository
    }
    
    func execute() -> AnyPublisher<TimeInterval, Never> {
        playerRepository.observePlaybackTime()
    }
}
