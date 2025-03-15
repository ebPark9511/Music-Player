//
//  PlayerState.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation

public enum PlayerState<T: Playable> {
    case playing(media: T)
    case paused(media: T)
    case stopped
}
