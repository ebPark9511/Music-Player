//
//  AudioService.swift
//  MediaKitInterface
//
//  Created by 박은비 on 3/22/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import Combine
import MediaPlayer

public protocol AudioService {
    func setVolume(_ volume: Float)
    func observeVolume() -> AnyPublisher<Float, Never>
}
