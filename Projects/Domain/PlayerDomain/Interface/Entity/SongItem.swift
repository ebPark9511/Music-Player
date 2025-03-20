//
//  SongItem.swift
//  PlayerDomain
//
//  Created by 박은비 on 3/20/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MediaKitInterface

public struct SongItem: Playable, SongEntity {
    public let id: String
    public let title: String?
    public let duration: TimeInterval
    public let trackNumber: Int
    public let artworkImage: (any ImageConvertible)?
    
    public init(id: String, title: String?, duration: TimeInterval, trackNumber: Int, artworkImage: (any ImageConvertible)?) {
        self.id = id
        self.title = title
        self.duration = duration
        self.trackNumber = trackNumber
        self.artworkImage = artworkImage
    }
}
