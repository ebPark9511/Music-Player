//
//  Album.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import UIKit

public struct Album: Equatable, Identifiable, Hashable {
    
    public let id: String
    public var title: String?
    public var artist: String?
    public var artworkImage: UIImage?
    public var songs: [Song]
    
    public init(id: String, title: String? = nil, artist: String? = nil, artworkImage: UIImage? = nil, songs: [Song]) {
        self.id = id
        self.title = title
        self.artist = artist
        self.artworkImage = artworkImage
        self.songs = songs
    }
    
}


