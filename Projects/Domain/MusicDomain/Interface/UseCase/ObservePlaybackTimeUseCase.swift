//
//  ObservePlaybackTimeUseCase.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import Combine

/// 현재 재생 중인 곡의 재생 시간을 감지한다
public protocol ObservePlaybackTimeUseCase {
    func execute() -> AnyPublisher<TimeInterval, Never>
}
