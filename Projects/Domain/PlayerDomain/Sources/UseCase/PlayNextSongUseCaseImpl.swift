//
//  PlayNextSongUseCaseImpl.swift
//  PlayerDomain
//
//  Created by 박은비 on 3/22/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import PlayerDomainInterface
import MediaKitInterface

final class PlayNextSongUseCaseImpl: PlayNextSongUseCase {
    
    private let mediaService: MediaService
    
    init(
        mediaService: MediaService
    ) {
        self.mediaService = mediaService
    }
    
    func execute() {
        mediaService.next()
    }
    
}
