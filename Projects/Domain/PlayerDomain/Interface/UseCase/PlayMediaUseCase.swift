//
//  PlaySongUseCase.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation

public protocol PlayMediaUseCase {
    func execute<T: Playable>(media: T) async throws
}
