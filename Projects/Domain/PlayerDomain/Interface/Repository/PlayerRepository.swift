//
//  PlayerRepository.swift
//  PlayerDomain
//
//  Created by 박은비 on 3/19/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MediaKitInterface
import Combine

public protocol PlayerRepository {
    func play(items: [Playable], isShuffle: Bool)
    func resume()
    func pause()
    func previous()
    func next()
    
    func observeNowPlaying() -> AnyPublisher<Playable?, Never>
    func observePlaybackTime() -> AnyPublisher<TimeInterval, Never>
    func observePlaybackState() -> AnyPublisher<PlayerState, Never>
}

