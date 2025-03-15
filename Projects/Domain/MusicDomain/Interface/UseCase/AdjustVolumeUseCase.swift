//
//  AdjustVolumeUseCase.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation

/// 볼륨 조절
public protocol AdjustVolumeUseCase {
    func execute(volume: Float) 
}
