//
//  FetchSongsUseCase.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation

/// 특정 앨범의 곡 목록을 가져온다.
public protocol FetchSongsUseCase {
    func execute(album: Album) async throws -> [Song]
}
