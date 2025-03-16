//
//  MediaItemMapper.swift
//  MediaKit
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MediaPlayer
import MusicDomainInterface

enum MediaItemMapper {
    static func toAlbum(_ collection: MPMediaItemCollection) -> Album? {
        let mediaItems = collection.items
        guard let representative = collection.representativeItem ?? mediaItems.first else { return nil }
        
        let id: String = representative.albumPersistentID.description
        let title: String = representative.albumTitle ?? ""
        let artist: String = representative.albumArtist ?? representative.artist ?? ""
        let artwork: ImageConvertible? = representative.artwork.map(ArtworkImageConverter.init)
        let songs: [Song] = mediaItems.map(toSong)
        
        return Album(
            id: id,
            title: title,
            artist: artist,
            artwork: artwork,
            songs: songs
        )
    }
    
    static func toSong(_ mediaItem: MPMediaItem) -> Song {
        Song(
            id: mediaItem.playbackStoreID,
            title: mediaItem.title ?? "",
            duration: mediaItem.playbackDuration,
            albumID: mediaItem.albumPersistentID.description,
            trackNumber: mediaItem.albumTrackNumber
        )
    }
} 