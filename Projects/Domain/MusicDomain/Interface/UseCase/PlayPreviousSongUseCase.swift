//
//  PlayPreviousSongUseCase.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation

/// 이전 곡 재생
/// 현재 곡이 3초 이상 재생된 경우 → 곡 처음부터 다시 시작.
/// 현재 곡이 3초 이하 재생된 경우 → 이전 곡으로 이동.
public protocol PlayPreviousSongUseCase {
    func execute() async throws
}
