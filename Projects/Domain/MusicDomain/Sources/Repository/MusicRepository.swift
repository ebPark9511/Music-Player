//
//  MusicRepositoryImpl.swift
//  MusicDomain
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MusicDomainInterface

protocol MusicRepository {
    func fetchAlbums() async throws -> [Album]
}

final class MusicRepositoryImpl: MusicRepository {
    
    private let localMusicDataSource: LocalMusicDataSource
    
    init(localMusicDataSource: LocalMusicDataSource) {
        self.localMusicDataSource = localMusicDataSource
    }
    
    func fetchAlbums() async throws -> [Album] {
        try await localMusicDataSource.fetchAlbums()
    }
}
