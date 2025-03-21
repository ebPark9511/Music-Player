//
//  ToggleShuffleModeUseCase.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation

/// 셔플을 ON/OFF 한다.
public protocol ToggleShuffleModeUseCase {
    func execute(isOn: Bool)
}

