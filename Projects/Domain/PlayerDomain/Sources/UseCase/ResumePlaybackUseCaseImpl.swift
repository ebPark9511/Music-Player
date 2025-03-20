//
//  ResumePlaybackUseCaseImpl.swift
//  PlayerDomain
//
//  Created by 박은비 on 3/20/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import PlayerDomainInterface
import MediaKitInterface

final class ResumePlaybackUseCaseImpl: ResumePlaybackUseCase {
    
    private let playerRepository: PlayerRepository
    
    init(
        playerRepository: PlayerRepository
    ) {
        self.playerRepository = playerRepository
    }
    
    func execute() {
        playerRepository.resume()
    }

}
