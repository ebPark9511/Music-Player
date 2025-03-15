//
//  SeekToTimeUseCase.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation

/// 재생 시간을 이동한다 (seek)
public protocol SeekToTimeUseCase {
    func execute(time: TimeInterval) async
}
