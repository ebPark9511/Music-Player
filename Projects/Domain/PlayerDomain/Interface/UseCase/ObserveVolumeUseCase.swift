//
//  ObserveVolumeUseCase.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import Combine

/// 현재 볼륨을 감지한다
public protocol ObserveVolumeUseCase {
    func execute() -> AnyPublisher<Float, Never>
}
