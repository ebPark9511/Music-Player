//
//  MediaLibraryDataSource.swift
//  MediaKit
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MediaPlayer
import MusicDomainInterface

public final class MediaLibraryDataSource: LocalMusicDataSource {
    private let mediaLibrary: MPMediaLibrary
    
    public init(mediaLibrary: MPMediaLibrary = MPMediaLibrary()) {
        self.mediaLibrary = mediaLibrary
    }
    
    public func fetchAlbums() async throws -> [Album] {
        guard let mediaCollections = MPMediaQuery.albums().collections else {
            return []
        }
        
        return mediaCollections.compactMap { MediaItemMapper.toAlbum($0) }
    }
} 