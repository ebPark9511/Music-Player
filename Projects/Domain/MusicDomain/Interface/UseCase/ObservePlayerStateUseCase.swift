//
//  ObservePlayerStateUseCase.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import Combine

/// 현재 재생 상태를 감지한다.
public protocol ObservePlayerStateUseCase {
    func execute() -> AnyPublisher<PlayerState, Never>
}
