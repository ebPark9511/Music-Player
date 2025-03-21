//
//  AdjustVolumeUseCaseImpl.swift
//  PlayerDomain
//
//  Created by 박은비 on 3/21/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import PlayerDomainInterface
import MediaKitInterface

final class AdjustVolumeUseCaseImpl: AdjustVolumeUseCase {
    
    private let audiaService: AudioService
    
    init(
        audiaService: AudioService
    ) {
        self.audiaService = audiaService
    }
    
    func execute(volume: Float) {
        audiaService.setVolume(volume)
    }

}

