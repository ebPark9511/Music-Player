//
//  PlayShuffleMediaUseCase.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import Combine
import MediaKitInterface

public protocol PlayShuffleMediaUseCase {
    func execute(items: [SongEntity])
}
