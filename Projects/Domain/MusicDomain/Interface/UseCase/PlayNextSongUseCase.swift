//
//  PlayNextSongUseCase.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation

/// 다음 곡을 재생한다
/// 셔플 모드가 켜져있는 경우 → 랜덤하게 선택된 다음 곡 재생
/// 셔플 모드가 꺼져있는 경우 → 현재 앨범의 다음 트랙 재생
public protocol PlayNextSongUseCase {
    func execute() async throws
}
