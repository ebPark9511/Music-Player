//
//  Song.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation

public struct Song: Identifiable {
    public let id: String
    public let title: String
    public let duration: TimeInterval
    public let albumID: String
    public let trackNumber: Int
    
    public init(id: String, title: String, duration: TimeInterval, albumID: String, trackNumber: Int) {
        self.id = id
        self.title = title
        self.duration = duration
        self.albumID = albumID
        self.trackNumber = trackNumber
    }
}
