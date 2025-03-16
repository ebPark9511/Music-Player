//
//  LocalMusicDataSource.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MusicDomainInterface
import MediaPlayer

protocol LocalMusicDataSource {
    func fetchAlbums() async throws -> [Album]
}

final class LocalMusicDataSourceImpl: LocalMusicDataSource {
    
    private struct ArtworkImageConverter: ImageConvertible {
        
        private let artwork: MPMediaItemArtwork
        
        init(artwork: MPMediaItemArtwork) {
            self.artwork = artwork
        }
        
        func image(at size: CGSize) -> UIImage? {
            artwork.image(at: size)
        }
    }
    
    func fetchAlbums() async throws -> [Album] {
        guard let mediaCollections = MPMediaQuery.albums().collections else {
            return []
        }
        
        return mediaCollections.compactMap { collection in
            let mediaItems = collection.items
            guard let representative = collection.representativeItem ?? mediaItems.first else { return nil }
            
            let id: String = representative.albumPersistentID.description
            let title: String = representative.albumTitle ?? ""
            let artist: String = representative.albumArtist ?? representative.artist ?? ""
            let artwork: ImageConvertible? = representative.artwork == nil ? nil : ArtworkImageConverter(artwork: representative.artwork!)
            let songs: [Song] = mediaItems.toSongs
            
            return Album(
                id: id,
                title: title,
                artist: artist,
                artwork: artwork,
                songs: songs
            )
        }
    }
}

private extension Array where Self.Element == MPMediaItem {
    var toSongs: [Song] {
        self.map { mediaItem in
            Song(
                id: mediaItem.playbackStoreID,
                title: mediaItem.title ?? "",
                duration: mediaItem.playbackDuration,
                albumID: mediaItem.albumPersistentID.description,
                trackNumber: mediaItem.albumTrackNumber
            )
        }

    }
}
