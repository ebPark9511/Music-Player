//
//  MPMediaItemCollection+AlbumEntity.swift
//  MediaKitInterface
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import UIKit
import MediaKitInterface
import MediaPlayer

extension MPMediaItemCollection: @retroactive AlbumEntity {

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
    
    public var artworkImage: UIImage? {
        _representativeItem.artwork == nil ? nil : _representativeItem.artwork?.image(at: .init(width: 200, height: 200))
    }
    
    public var songs: [any SongEntity] {
        self.items.map { $0 as SongEntity }
    }
    
    
}
