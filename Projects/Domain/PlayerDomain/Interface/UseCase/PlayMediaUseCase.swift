//
//  PlayMediaUseCase.swift
//  PlayerDomainInterface
//
//  Created by 박은비 on 3/19/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MediaKitInterface

/// items을 재생한다
public protocol PlayMediaUseCase {
    func execute(items: [Playable])
}
