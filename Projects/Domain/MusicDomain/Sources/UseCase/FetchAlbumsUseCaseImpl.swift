//
//  FetchAlbumsUseCaseImpl.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MusicDomainInterface

final class FetchAlbumsUseCaseImpl: FetchAlbumsUseCase {
    private let musicRepository: MusicRepository

    init(musicRepository: MusicRepository) {
        self.musicRepository = musicRepository
    }

    func execute() async throws -> [Album] {
        return try await musicRepository.fetchAlbums()
    }
}
