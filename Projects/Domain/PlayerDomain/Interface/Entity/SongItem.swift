//
//  SongItem.swift
//  PlayerDomain
//
//  Created by 박은비 on 3/20/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import UIKit
import MediaKitInterface

public struct SongItem: Playable, SongEntity {
    
    public let id: String
    public let title: String?
    public let artist: String?
    public let artworkImage: UIImage?
    public let duration: TimeInterval
    
    public init(id: String, title: String?, artist: String? = nil, artworkImage: UIImage? = nil, duration: TimeInterval) {
        self.id = id
        self.title = title
        self.artist = artist
        self.artworkImage = artworkImage
        self.duration = duration
    }
    
    public init(
        entity: SongEntity
    ) {
        self.id = entity.id
        self.title = entity.title
        self.artist = entity.artist
        self.artworkImage = entity.artworkImage
        self.duration = entity.duration
    }
    
    public init(
        playableEntity entity: Playable
    ) {
        self.id = entity.id
        self.title = entity.title
        self.artist = entity.artist
        self.artworkImage = entity.artworkImage
        self.duration = entity.duration
    }
}
