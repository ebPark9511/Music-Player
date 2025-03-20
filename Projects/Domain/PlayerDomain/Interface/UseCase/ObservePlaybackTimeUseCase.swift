//
//  ObservePlaybackTimeUseCase.swift
//  PlayerDomainInterface
//
//  Created by 박은비 on 3/21/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import Combine

public protocol ObservePlaybackTimeUseCase {
    func execute() -> AnyPublisher<TimeInterval, Never>
}
