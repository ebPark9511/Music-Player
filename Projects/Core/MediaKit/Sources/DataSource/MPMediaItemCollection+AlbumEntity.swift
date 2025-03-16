//
//  MPMediaItemCollection+AlbumEntity.swift
//  MediaKitInterface
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MediaKitInterface
import MediaPlayer

extension MPMediaItemCollection: @retroactive AlbumEntity {

    private struct ArtworkImageConverter: ImageConvertible {
        
        private let artwork: MPMediaItemArtwork
        
        init(artwork: MPMediaItemArtwork) {
            self.artwork = artwork
        }
        
        func image(at size: CGSize) -> UIImage? {
            artwork.image(at: size)
        }
    }
    
    private var _representativeItem: MPMediaItem {
        self.representativeItem ?? self.items.first!
    }

    public var id: String {
        _representativeItem.albumPersistentID.description
    }
    
    public var title: String? {
        _representativeItem.albumTitle
    }
    
    public var artist: String? {
        _representativeItem.albumArtist ?? _representativeItem.artist
    }
    
    public var artworkImage: (any ImageConvertible)? {
        _representativeItem.artwork == nil ? nil : ArtworkImageConverter(artwork: _representativeItem.artwork!)
    }
    
    public var songs: [any MediaKitInterface.SongEntity] {
        self.items
    }
    
    
}
