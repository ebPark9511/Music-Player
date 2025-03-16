//
//  MusicRepositoryImpl.swift
//  MusicDomain
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MusicDomainInterface
import MediaKitInterface

final class MusicRepositoryImpl: MusicRepository {
    
    private let authorizeMediaLibraryService: AuthorizeMediaLibraryService
    private let mediaLibraryDataSource: MediaLibraryDataSource
    
    init(
        authorizeMediaLibraryService: AuthorizeMediaLibraryService,
        mediaLibraryDataSource: MediaLibraryDataSource
    ) {
        self.authorizeMediaLibraryService = authorizeMediaLibraryService
        self.mediaLibraryDataSource = mediaLibraryDataSource
    }
    
    private func checkAuthorization() async throws {
        let status = authorizeMediaLibraryService.getAuthorizationStatus()
        switch status {
        case .notDetermined:
            let newStatus = await authorizeMediaLibraryService.requestAuthorization()
            guard newStatus == .authorized else {
                throw MusicDomainError.unauthorized
            }
        case .authorized:
            break
        case .denied, .restricted:
            throw MusicDomainError.unauthorized
        }
    }
    
    func fetchAlbums() async throws -> [Album] {
        try await checkAuthorization()
        
        return await mediaLibraryDataSource.fetchAlbums().map { $0.asAlbum }
    }
    
}

// MARK: - Mapping Extensions
private extension AlbumEntity {
    var asAlbum: Album {
        Album(
            id: id,
            title: title,
            artist: artist,
            artworkImage: artworkImage?.image(at: .init(width: 200, height: 200)),
            songs: songs.map { $0.asSong }
        )
    }
}

private extension SongEntity {
    var asSong: Song {
        Song(
            id: id,
            duration: duration,
            trackNumber: trackNumber
        )
    }
}
