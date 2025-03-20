//
//  ObserveCurrentSongUseCase.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import Combine
import MediaKitInterface

/// 현재 재생 중인 곡을 감지한다.
public protocol ObserveCurrentSongUseCase {
    func execute() -> AnyPublisher<SongEntity?, Never>
}

