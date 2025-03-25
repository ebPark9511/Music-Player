//
//  Song.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import UIKit

public struct Song: Equatable, Identifiable, Hashable, Sendable {
    public let id: String
    public let title: String?
    public let artist: String?
    public let artworkImage: UIImage?
    public let duration: TimeInterval
    public let trackNumber: Int
    
    public init(id: String, title: String? = nil, artist: String? = nil, artworkImage: UIImage? = nil, duration: TimeInterval, trackNumber: Int) {
        self.id = id
        self.title = title
        self.artist = artist
        self.artworkImage = artworkImage
        self.duration = duration
        self.trackNumber = trackNumber
    }
   
}
