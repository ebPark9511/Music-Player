//
//  Album.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation

public struct Album {
    public let id: String
    public let title: String
    public let artist: String
    public let artworkURL: URL?
    public let songs: [Song]
}
