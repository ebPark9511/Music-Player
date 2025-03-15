//
//  ResumePlaybackUseCase.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation

/// 일시정지된 곡을 다시 재생한다
public protocol ResumePlaybackUseCase {
    func execute() async
}


