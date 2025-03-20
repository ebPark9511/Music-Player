//
//  MediaService.swift
//  MediaKitInterface
//
//  Created by 박은비 on 3/20/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import Combine
import MediaPlayer

public protocol MediaService {
    @discardableResult
    func play(items: [SongEntity], isShuffle: Bool) -> [SongEntity]
    func resume()
    func pause()
    
    func observeNowPlaying() -> AnyPublisher<SongEntity?, Never>
    func observePlaybackState() -> AnyPublisher<MPMusicPlaybackState?, Never>
}
