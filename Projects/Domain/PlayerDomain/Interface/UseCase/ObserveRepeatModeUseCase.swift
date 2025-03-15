//
//  ObserveRepeatModeUseCase.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import Combine

/// 현재 반복 모드를 감지한다
public protocol ObserveRepeatModeUseCase {
    func execute() -> AnyPublisher<Bool, Never>
}
