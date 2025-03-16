//
//  Album.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation

public struct Album: Identifiable {
    public let id: String
    public let title: String
    public let artist: String
    public let artwork: ImageConvertible?
    public let songs: [Song]
    
    public init(id: String, title: String, artist: String, artwork: ImageConvertible?, songs: [Song]) {
        self.id = id
        self.title = title
        self.artist = artist
        self.artwork = artwork
        self.songs = songs
    }
}
