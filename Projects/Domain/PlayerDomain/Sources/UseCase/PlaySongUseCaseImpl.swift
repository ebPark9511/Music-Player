//
//  PlaySongUseCaseImpl.swift
//  PlayerDomainInterface
//
//  Created by 박은비 on 3/19/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import PlayerDomainInterface
import MediaKitInterface

final class PlayMediaUseCaseImpl: PlayMediaUseCase {
    
    private let mediaService: MediaService
    
    init(
        mediaService: MediaService
    ) {
        self.mediaService = mediaService
    }
    
    func execute(items: [Playable]) {
        mediaService.play(items: items.map { SongItem(playableEntity: $0) }, isShuffle: false)
    }
    
    
}


