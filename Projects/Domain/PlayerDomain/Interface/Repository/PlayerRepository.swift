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
    func play(items: [SongEntity], isShuffle: Bool)
    func observePlayingList() -> AnyPublisher<[SongEntity], Never>
    func observeNowPlaying() -> AnyPublisher<SongEntity?, Never>
}
